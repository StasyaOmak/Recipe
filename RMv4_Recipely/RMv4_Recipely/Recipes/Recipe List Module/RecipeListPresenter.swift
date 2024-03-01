// RecipeListPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс презентера модуля "Рецепты выбранной категории"
protocol RecipeListPresenterProtocol: AnyObject {
    /// свойство типа вью этого модуля
    var view: RecipeListViewController? { get set }
    /// свойство-координатор
    var coordinator: RecipesCoordinator? { get set }

    /// Метод установки категории на экран
    func setCategory(category: DishCategory)
    /// Метод-флаг возврата на прдыдущий экран
    func popToAllRecipes()
    /// метод-флаг нажатия на кнопку фильтра
    func filterButtonPressed(sender: FilterButton)
}

/// Презентер модуля "Рецепты выбранной категории"
final class RecipeListPresenter {
    weak var view: RecipeListViewController?
    weak var coordinator: RecipesCoordinator?
}

// MARK: - Extension RecipeListPresenter + RecipeListPresenterProtocol

extension RecipeListPresenter: RecipeListPresenterProtocol {
    func setCategory(category: DishCategory) {
        let title = category.type.rawValue.capitalized
        view?.setTitle(title)
        let recipes = RecipeDescription.getMockData(category: category)
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
}
