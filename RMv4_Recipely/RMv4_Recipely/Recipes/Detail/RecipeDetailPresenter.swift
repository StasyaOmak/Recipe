// RecipeDetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс презентера модуля "Детальный экран"
protocol RecipeDetailPresenterProtocol: AnyObject {
    /// Рецепт, отображаемый в детальном экране
    var recipe: String { get set }
    /// Состояние загрузки данных модуля
    var state: State<FullRecipe> { get set }
    /// Экшн кнопки назад
    func popToAllRecipes()
    /// метод добавления рецепта в избранное
    func addToFavorites(fullRecipe: FullRecipe)
    /// метод проверки, находится ли отображаемый рецепт в избранном
    func checkIfFavorite(fullRecipe: FullRecipe)
    /// поделиться рецептом
    func shareRecipe(message: LogAction)
    /// Добавление логов
    func sendLog(message: LogAction)
    /// Загружает с сети детальное описание рецепта
    func getRecipeDescription()
    /// Метод на загрузку/проверку изображения в кэше
    func loadImage(url: URL?, completion: @escaping (Data) -> ())
    /// Инициализатор с присвоением вью
    init(
        coordinator: RecipesCoordinator,
        view: RecipeDetailViewProtocol,
        loggerManager: LoggerManagerProtocol,
        networkService: NetworkServiceProtocol,
        imageLoader: LoadImageServiceProtocol,
        recipe: String
    )
}

final class RecipeDetailPresenter: RecipeDetailPresenterProtocol {
    // MARK: - Public Properties

    var recipe: String

    var state: State<FullRecipe> = .loading {
        didSet {
            view?.updateState()
        }
    }

    // MARK: - Private Properties

    private weak var coordinator: RecipesCoordinator?
    private weak var view: RecipeDetailViewProtocol?
    private var loggerManager: LoggerManagerProtocol?
    private var networkService: NetworkServiceProtocol?
    private var imageLoader: LoadImageServiceProtocol?

    // MARK: - Initializers

    init(
        coordinator: RecipesCoordinator,
        view: RecipeDetailViewProtocol,
        loggerManager: LoggerManagerProtocol,
        networkService: NetworkServiceProtocol,
        imageLoader: LoadImageServiceProtocol, recipe: String
    ) {
        self.coordinator = coordinator
        self.view = view
        self.loggerManager = loggerManager
        self.networkService = networkService
        self.imageLoader = imageLoader
        self.recipe = recipe
    }

    // MARK: - Public Methods

    func getRecipeDescription() {
        state = .loading
        let coreDataRecipe = CoreDataService.shared.fetchFullRecipe(uri: recipe)
        if coreDataRecipe == nil {
            networkService?.getSingleRecipe(
                recipeUri: recipe,
                completion: { [weak self] result in
                    switch result {
                    case let .success(recipe):
                        guard let recipe else { return }
                        self?.state = self?.recipe != nil ? .data(recipe) : .noData
                        CoreDataService.shared.createFullRecipe(recipe: recipe)
                        DispatchQueue.main.async { [weak self] in
                            self?.checkIfFavorite(fullRecipe: recipe)
                        }
                    case let .failure(error):
                        self?.state = .error(error)
                    }
                }
            )
        } else {
            guard let coreDataRecipe else { return }
            state = .data(coreDataRecipe)
            DispatchQueue.main.async { [weak self] in
                self?.checkIfFavorite(fullRecipe: coreDataRecipe)
            }
        }
        view?.updateState()
    }

    func shareRecipe(message: LogAction) {
        loggerManager?.log(message)
    }

    func sendLog(message: LogAction) {
        loggerManager?.log(message)
    }

    func popToAllRecipes() {
        coordinator?.popToAllRecipes()
    }

    func addToFavorites(fullRecipe: FullRecipe) {
        var recipes = FavoriteService.shared.getFavorites()
        if recipes.filter({ $0.uri == fullRecipe.recipeURI }).isEmpty {
            recipes.append(ShortRecipe(fullRecipe: fullRecipe))
            FavoriteService.shared.save(recipes)
        }
    }

    func checkIfFavorite(fullRecipe: FullRecipe) {
        var recipes = FavoriteService.shared.getFavorites()
        if recipes.contains(where: { $0.uri == fullRecipe.recipeURI }) {
            view?.setRedAddToFavoritesButtonColor()
        } else {
            view?.setBlackAddToFavoritesButtonColor()
        }
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
}
