// RecipeDetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс презентера модуля "Детальный экран"
protocol RecipeDetailPresenterProtocol: AnyObject {
    /// Рецепт, отображаемый в детальном экране
    var recipe: RecipeDescription? { get set }
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
    /// Инициализатор с присвоением вью
    init(
        coordinator: RecipesCoordinator,
        view: RecipeDetailViewProtocol,
        recipe: RecipeDescription,
        loggerManager: LoggerManagerProtocol
    )
}

final class RecipeDetailPresenter: RecipeDetailPresenterProtocol {
    // MARK: - Public Properties

    var state: State<FullRecipe> = .loading {
        didset {
            self.view.stat
        }
    }

    // MARK: - Private Properties

    private weak var coordinator: RecipesCoordinator?
    private weak var view: RecipeDetailViewProtocol?
    private var loggerManager: LoggerManagerProtocol?
    var recipe: RecipeDescription?

    // MARK: - Initializers

    init(
        coordinator: RecipesCoordinator,
        view: RecipeDetailViewProtocol,
        recipe: RecipeDescription,
        loggerManager: LoggerManagerProtocol
    ) {
        self.coordinator = coordinator
        self.view = view
        self.recipe = recipe
        self.loggerManager = loggerManager
    }

    // MARK: - Public Methods

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
        guard let recipe else { return }
        if FavoriteService.shared.getFavorites().filter({ $0 == recipe }).isEmpty {
            FavoriteService.shared.addFavorite(recipe)
            view?.setRedAddToFavoritesButtonColor()
        } else {
            for (index, element) in FavoriteService.shared.getFavorites().enumerated() where element == recipe {
                FavoriteService.shared.removeFavorite(index)
            }
            view?.setBlackAddToFavoritesButtonColor()
        }
    }

    func checkIfFavorite() {
        guard let recipe else { return }
        if FavoriteService.shared.getFavorites().contains(recipe) { view?.setRedAddToFavoritesButtonColor()
        } else {
            view?.setBlackAddToFavoritesButtonColor()
        }
    }
}
