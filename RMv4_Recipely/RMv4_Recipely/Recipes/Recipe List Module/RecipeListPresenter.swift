// RecipeListPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс презентера модуля "Рецепты выбранной категории"
protocol RecipeListPresenterProtocol: AnyObject {
    /// State
    var state: State<[ShortRecipe]>? { get set }
    /// Метод установки категории на экран
    func setCategory(category: DishCategory)
    /// Метод-флаг возврата на прдыдущий экран
    func popToAllRecipes()
    /// метод-флаг нажатия на кнопку фильтра
    func filterButtonPressed(sender: FilterButton)
    /// Переход в экран с описанием рецепта
    func pushToDetail(uri: String)
    /// Поиск рецептов по запросу
    func searchRecipes(withText text: String)
    /// Начать поиск
    func startSearch()
    /// Остановить поиск
    func stopSearch()
    /// парсит рецепт
    func getRecipes()
    /// загрузка картинки в кэш
    func loadImage(url: URL?, completion: @escaping (Data) -> ())

    /// Инициализатор с присвоением вью
    init(
        view: RecipeListViewControllerProtocol,
        coordinator: RecipesCoordinator,
        loggerManager: LoggerManagerProtocol,
        networkService: NetworkServiceProtocol,
        imageLoader: LoadImageServiceProtocol
    )

    /// Добавление логов
    func sendLog(message: LogAction)
}

/// Презентер модуля "Рецепты выбранной категории"
final class RecipeListPresenter {
    // MARK: - Constants

    private enum Constants {
        static let loadingRecipesDelay: DispatchTime = .now() + 3
    }

    // MARK: - Public Properties

    var state: State<[ShortRecipe]>? = .loading {
        didSet {
            view?.reloadTableView()
        }
    }

    // MARK: - Private Properties

    private weak var view: RecipeListViewControllerProtocol?
    private weak var coordinator: RecipesCoordinator?
    private var category: DishCategory?
    private var loggerManager: LoggerManagerProtocol?
    private var networkService: NetworkServiceProtocol?
    private var imageLoader: LoadImageServiceProtocol?

    private var sourceOfRecepies: [ShortRecipe] = []
    private var isSearching = false
    private var searchedRecipes: [ShortRecipe] = []
    private var query: String?
    private var searchedText = ""
    private var health: String?

    // MARK: - Initializers

    init(
        view: RecipeListViewControllerProtocol,
        coordinator: RecipesCoordinator,
        loggerManager: LoggerManagerProtocol,
        networkService: NetworkServiceProtocol,
        imageLoader: LoadImageServiceProtocol
    ) {
        self.view = view
        self.coordinator = coordinator
        self.loggerManager = loggerManager
        self.networkService = networkService
        self.imageLoader = imageLoader
    }
}

// MARK: - RecipeListPresenter + RecipeListPresenterProtocol

extension RecipeListPresenter: RecipeListPresenterProtocol {
    func getRecipes() {
        state = .loading
        guard let category else { return }
        let coreDataRecipe = CoreDataService.shared.fetchShortRecipes(dishType: category)
        if coreDataRecipe.isEmpty {
            networkService?.getRecipes(
                dishType: category,
                health: makeHealth(),
                query: makeQuery(searchText: searchedText),
                completion: { [weak self] result in
                    DispatchQueue.main.async {
                        switch result {
                        case let .success(recipes):
                            self?.state = !recipes.isEmpty ? .data(recipes) : .noData
                            CoreDataService.shared.createShortRecipe(recipes: recipes, category: category)
                        case let .failure(error):
                            self?.state = .error(error)
                        }
                    }
                }
            )
        } else {
            state = .data(coreDataRecipe)
        }
        view?.reloadTableView()
    }

    func makeQuery(searchText: String) -> String? {
        var query: String?
        guard let category else { return nil }
        query = category.type.urlComponent == "Main course" ? category.type.rawValue : nil
        print(searchText)
        switch query {
        case .some:
            query?.append(" ")
            query?.append(searchText)
        case .none:
            if searchText.count != 0 {
                query = searchText
            }
        }
        return query
    }

    func makeHealth() -> String? {
        var health: String?
        guard let category else { return nil }
        health = category.type.urlComponent == "Side Dish" ? "Vegetarian" : nil
        return health
    }

    func loadImage(url: URL?, completion: @escaping (Data) -> ()) {
        guard let url else { return }
        imageLoader?.loadImage(url: url, completion: { data, _, _ in
            guard let data else { return }
            DispatchQueue.main.async {
                completion(data)
            }
        })
    }

    func sendLog(message: LogAction) {
        loggerManager?.log(message)
    }

    func searchRecipes(withText text: String) {
        guard !text.isEmpty else {
            isSearching = false
            searchedRecipes = []
            view?.reloadTableView()
            return
        }
        isSearching = true
        searchedText = " \(text)"
        query = searchedText
        getRecipes()
        searchedRecipes = sourceOfRecepies.filter {
            if let recipeLabel = $0.label {
                recipeLabel.lowercased().contains(text.lowercased())
            } else {
                false
            }
        }
        view?.setRecipes(searchedRecipes)
    }

    func stopSearch() {
        isSearching = false
    }

    func startSearch() {
        isSearching = true
        view?.setRecipes(searchedRecipes)
    }

    func setCategory(category: DishCategory) {
        let title = category.type.rawValue.capitalized
        view?.setTitle(title)
        self.category = category
        var recipes: [ShortRecipe] = []
        if isSearching {
            recipes = searchedRecipes
        } else {
            recipes = sourceOfRecepies
        }
        view?.setRecipes(recipes)
    }

    func popToAllRecipes() {
        coordinator?.popToAllRecipes()
    }

    func filterButtonPressed(sender: FilterButton) {
        if sender.isPressed == false {
            sender.isPressed = true
            sender.isInIncreaseOrder = true
            sender.isInDecreaseOrder = false
            switch sender.tag {
            case 0:
                caloriesButtonTriggered(sender: sender)
            case 1:
                timeButtonTriggered(sender: sender)
            default:
                break
            }
        } else {
            switch sender.tag {
            case 0:
                caloriesButtonTriggered(sender: sender)
            case 1:
                timeButtonTriggered(sender: sender)
            default:
                break
            }
        }
    }

    func pushToDetail(uri: String) {
        coordinator?.pushToDetail(recipeUri: uri)
    }

    // TODO: - нарушена логика сортировки - при проверке состояния второго фильтра приходится сортировать в порядке, обратном проверяемому свойству.
    private func caloriesButtonTriggered(sender: FilterButton) {
        guard let anotherFilterState = view?.checkAnotherFilter(sender: sender) else { return }
        sender.isPressed = true
        if sender.isInIncreaseOrder {
            checkForIncreaseCaloriesSearch(sender: sender, anotherFilterState: anotherFilterState)
        } else {
            checkForDecreaseCaloriesSearch(sender: sender, anotherFilterState: anotherFilterState)
        }
    }

    private func timeButtonTriggered(sender: FilterButton) {
        guard let category, let anotherFilterState = view?.checkAnotherFilter(sender: sender) else { return }
        sender.isPressed = true
        if sender.isInIncreaseOrder {
            checkForIncreaseTimeSearch(category: category, sender: sender, anotherFilterState: anotherFilterState)
        } else {
            checkForDecreaseTimeSearch(category: category, sender: sender, anotherFilterState: anotherFilterState)
        }
    }
}

// MARK: - TableView Sorting Methods

extension RecipeListPresenter {
    func checkForIncreaseCaloriesSearch(
        sender: FilterButton,
        anotherFilterState: (isPressed: Bool, increasing: Bool, decreasing: Bool)
    ) {
        switch state {
        case let .data(recipes):
            sender.isInIncreaseOrder = false
            sender.isInDecreaseOrder = true
            if anotherFilterState.isPressed {
                switch anotherFilterState.increasing {
                case true:
                    let sortedRecipes = recipes.sorted(by: {
                        if $0.calories == $1.calories {
                            $0.totalTime > $1.totalTime
                        } else {
                            $0.calories < $1.calories
                        }
                    })
                    state = .data(sortedRecipes)
                case false:
                    let sortedRecipes = recipes.sorted(by: {
                        if $0.calories == $1.calories {
                            $0.totalTime < $1.totalTime
                        } else {
                            $0.calories < $1.calories
                        }
                    })
                    state = .data(sortedRecipes)
                }
            } else {
                let sortedRecipes = recipes.sorted(by: { $0.calories < $1.calories })
                state = .data(sortedRecipes)
            }
        default:
            break
        }
    }

    func checkForDecreaseCaloriesSearch(
        sender: FilterButton,
        anotherFilterState: (isPressed: Bool, increasing: Bool, decreasing: Bool)
    ) {
        switch state {
        case let .data(recipes):
            sender.isInIncreaseOrder = true
            sender.isInDecreaseOrder = false
            if anotherFilterState.isPressed {
                switch anotherFilterState.increasing {
                case true:
                    let sortedRecipes = recipes.sorted(by: {
                        if $0.calories == $1.calories {
                            $0.totalTime > $1.totalTime
                        } else {
                            $0.calories > $1.calories
                        }
                    })
                    state = .data(sortedRecipes)
                case false:
                    let sortedRecipes = recipes.sorted(by: {
                        if $0.calories == $1.calories {
                            $0.totalTime < $1.totalTime
                        } else {
                            $0.calories > $1.calories
                        }
                    })
                    state = .data(sortedRecipes)
                }
            } else {
                let sortedRecipes = recipes.sorted(by: { $0.calories > $1.calories })
                state = .data(sortedRecipes)
            }
        default:
            break
        }
    }

    func checkForIncreaseTimeSearch(
        category: DishCategory,
        sender: FilterButton,
        anotherFilterState: (isPressed: Bool, increasing: Bool, decreasing: Bool)
    ) {
        switch state {
        case let .data(recipes):
            sender.isInIncreaseOrder = false
            sender.isInDecreaseOrder = true
            if anotherFilterState.isPressed {
                switch anotherFilterState.increasing {
                case true:
                    let sortedRecipes = recipes.sorted(by: {
                        if $0.totalTime == $1.totalTime {
                            $0.calories > $1.calories
                        } else {
                            $0.totalTime < $1.totalTime
                        }
                    })
                    state = .data(sortedRecipes)
                case false:
                    let sortedRecipes = recipes.sorted(by: {
                        if $0.totalTime == $1.totalTime {
                            $0.calories < $1.calories
                        } else {
                            $0.totalTime < $1.totalTime
                        }
                    })
                    state = .data(sortedRecipes)
                }
            } else {
                let sortedRecipes = recipes.sorted(by: { $0.totalTime < $1.totalTime })
                state = .data(sortedRecipes)
            }
        default:
            break
        }
    }

    func checkForDecreaseTimeSearch(
        category: DishCategory,
        sender: FilterButton,
        anotherFilterState: (isPressed: Bool, increasing: Bool, decreasing: Bool)
    ) {
        switch state {
        case let .data(recipes):
            sender.isInIncreaseOrder = true
            sender.isInDecreaseOrder = false
            if anotherFilterState.isPressed {
                switch anotherFilterState.increasing {
                case true:
                    let sortedRecipes = recipes.sorted(by: {
                        if $0.totalTime == $1.totalTime {
                            $0.calories > $1.calories
                        } else {
                            $0.calories > $1.calories
                        }
                    })
                    state = .data(sortedRecipes)
                case false:
                    let sortedRecipes = recipes.sorted(by: {
                        if $0.totalTime == $1.totalTime {
                            $0.calories < $1.calories
                        } else {
                            $0.totalTime > $1.totalTime
                        }
                    })
                    state = .data(sortedRecipes)
                }
            } else {
                let sortedRecipes = recipes.sorted(by: { $0.totalTime > $1.totalTime })
                state = .data(sortedRecipes)
            }
        default:
            break
        }
    }
}
