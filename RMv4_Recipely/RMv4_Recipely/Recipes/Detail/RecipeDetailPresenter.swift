// RecipeDetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс презентера модуля "Детальный экран"
protocol RecipeDetailPresenterProtocol: AnyObject {
    /// Рецепт, отображаемый в детальном экране
    var recipe: FullRecipe? { get set }
    /// Состояние загрузки данных модуля
    var state: State<FullRecipe> { get set }
    /// Экшн кнопки назад
    func popToAllRecipes()
    /// метод добавления рецепта в избранное
    func addToFavorites()
    /// метод проверки, находится ли отображаемый рецепт в избранном
    func checkIfFavorite()
    /// поделиться рецептом
    func shareRecipe(message: LogAction)
    /// Добавление логов
    func sendLog(message: LogAction)
    ///
    func getRecipeDescription()
    /// Метод на загрузку/проверку изображения в кэше
    func loadImage(url: URL?, completion: @escaping (Data) -> ())
    /// Инициализатор с присвоением вью
    init(
        coordinator: RecipesCoordinator,
        view: RecipeDetailViewProtocol,
        loggerManager: LoggerManagerProtocol,
        networkService: NetworkServiceProtocol,
        imageLoader: LoadImageServiceProtocol
    )
}

final class RecipeDetailPresenter: RecipeDetailPresenterProtocol {
    // MARK: - Public Properties

    var recipe: FullRecipe?

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
        imageLoader: LoadImageServiceProtocol
    ) {
        self.coordinator = coordinator
        self.view = view
        self.loggerManager = loggerManager
        self.networkService = networkService
        self.imageLoader = imageLoader
    }

    // MARK: - Public Methods

    func getRecipeDescription() {
        networkService?.getSingleRecipe(
            recipeUri: "http://www.edamam.com/ontologies/edamam.owl#recipe_2c3f520229386d51f359475a58d539aa",
            completion: { [weak self] result in
                switch result {
                case let .success(recipe):
                    self?.recipe = recipe
                    guard let recipe else { return }
                    self?.state = self?.recipe != nil ? .data(recipe) : .noData
                case let .failure(error):
                    self?.state = .error(error)
                    print(error.localizedDescription)
                }
            }
        )
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

    func addToFavorites() {
        // TODO: - переделать с данными из сети, когда будет поставлена задача
//        guard let recipe else { return }
//        if FavoriteService.shared.getFavorites().filter({ $0 == recipe }).isEmpty {
//            FavoriteService.shared.addFavorite(recipe)
//            view?.setRedAddToFavoritesButtonColor()
//        } else {
//            for (index, element) in FavoriteService.shared.getFavorites().enumerated() where element == recipe {
//                FavoriteService.shared.removeFavorite(index)
//            }
//            view?.setBlackAddToFavoritesButtonColor()
//        }
    }

    func checkIfFavorite() {
        // TODO: - переделать с данными из сети, когда будет поставлена задача
//        guard let recipe else { return }
//        if FavoriteService.shared.getFavorites().isEmpty { view?.setRedAddToFavoritesButtonColor()
//        } else {
//            view?.setBlackAddToFavoritesButtonColor()
//        }
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
