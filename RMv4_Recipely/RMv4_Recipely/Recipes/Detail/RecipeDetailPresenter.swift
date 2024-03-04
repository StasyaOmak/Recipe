// RecipeDetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс презентера модуля "Детальный экран"
protocol RecipeDetailPresenterProtocol: AnyObject {
    /// Инициализатор с присвоением вью
    init(coordinator: RecipesCoordinator, view: RecipeDetailViewProtocol, recipe: RecipeDescription)
    /// Рецепт, отображаемый в детальном экране
    var recipe: RecipeDescription? { get set }
    /// Экшн кнопки назад
    func popToAllRecipes()
    /// метод добавления рецепта в избранное
    func addToFavorites()
    /// метод проверки, находится ли отображаемый рецепт в избранном
    func checkIfFavorite()
}

final class RecipeDetailPresenter: RecipeDetailPresenterProtocol {
    // MARK: - Private Properties

    private weak var coordinator: RecipesCoordinator?
    private weak var view: RecipeDetailViewProtocol?
    var recipe: RecipeDescription?

    // MARK: - Initializers

    init(coordinator: RecipesCoordinator, view: RecipeDetailViewProtocol, recipe: RecipeDescription) {
        self.coordinator = coordinator
        self.view = view
        self.recipe = recipe
    }

    // MARK: - Public Methods

    func popToAllRecipes() {
        coordinator?.popToAllRecipes()
    }

    func addToFavorites() {
        guard let recipe else { return }
        if RecipeDescription.favoritesRecipes.filter({ $0 == recipe }).isEmpty {
            RecipeDescription.favoritesRecipes.append(recipe)
            view?.setRedAddToFavoritesButtonColor()
        } else {
            for (index, element) in RecipeDescription.favoritesRecipes.enumerated() where element == recipe {
                RecipeDescription.favoritesRecipes.remove(at: index)
            }
            view?.setBlackAddToFavoritesButtonColor()
        }
    }

    func checkIfFavorite() {
        guard let recipe else { return }
        if RecipeDescription.favoritesRecipes.contains(recipe) { view?.setRedAddToFavoritesButtonColor()
        } else {
            view?.setBlackAddToFavoritesButtonColor()
        }
    }
}
