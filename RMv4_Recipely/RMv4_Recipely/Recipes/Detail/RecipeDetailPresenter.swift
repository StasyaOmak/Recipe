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
}
