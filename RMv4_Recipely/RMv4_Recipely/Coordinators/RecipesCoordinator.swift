// RecipesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор модуля "Рецепты"
final class RecipesCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var rootController: UINavigationController
    let appBuilder = AppBuilder()

    // MARK: - Initializers

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }

    func moveToRecipeListScreen(category: DishCategory) {
        let recipeListModule = appBuilder.makeRecipeListModule()
        recipeListModule.presenter?.coordinator = self
        recipeListModule.presenter?.setCategory(category: category)
        recipeListModule.hidesBottomBarWhenPushed = true
        rootController.pushViewController(recipeListModule, animated: true)
    }

    func popToAllRecipes() {
        rootController.popViewController(animated: true)
    }
}
