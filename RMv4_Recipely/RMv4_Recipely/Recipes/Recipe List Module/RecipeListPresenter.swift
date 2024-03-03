// RecipeListPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс презентера модуля "Рецепты выбранной категории"
protocol RecipeListPresenterProtocol: AnyObject {
    /// Метод установки категории на экран
    func setCategory(category: DishCategory)
    /// Метод-флаг возврата на прдыдущий экран
    func popToAllRecipes()
    /// метод-флаг нажатия на кнопку фильтра
    func filterButtonPressed(sender: FilterButton)

    func pushToDetail(recipe: RecipeDescription)
}

/// Презентер модуля "Рецепты выбранной категории"
final class RecipeListPresenter {
    // MARK: - Private Properties

    private weak var view: RecipeListViewControllerProtocol?
    private weak var coordinator: RecipesCoordinator?

    // MARK: - Initializers

    init(view: RecipeListViewControllerProtocol, coordinator: RecipesCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}

// MARK: - RecipeListPresenter + RecipeListPresenterProtocol

extension RecipeListPresenter: RecipeListPresenterProtocol {
    func setCategory(category: DishCategory) {
        let title = category.type.rawValue.capitalized
        view?.setTitle(title)
        let recipes = RecipeDescription.getRecipes(category: category)
        view?.setRecipes(recipes)
    }

    func popToAllRecipes() {
        coordinator?.popToAllRecipes()
    }

    func filterButtonPressed(sender: FilterButton) {
        if sender.isPressed == false {
            view?.disableAllFilterButtons()
            sender.isPressed = !sender.isPressed
        } else {
            sender.isPressed = true
            sender.isInIncreaseOrder = !sender.isInIncreaseOrder
            sender.isInDecreaseOrder = !sender.isInDecreaseOrder
        }
    }

    func pushToDetail(recipe: RecipeDescription) {
        coordinator?.pushToDetail(recipe: recipe)
    }
}
