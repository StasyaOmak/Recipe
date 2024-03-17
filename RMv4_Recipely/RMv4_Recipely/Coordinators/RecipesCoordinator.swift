// RecipesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор модуля "Рецепты"
final class RecipesCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var rootController: UINavigationController?
    let appBuilder: AppBuilder

    // MARK: - Initializers

    init(appBuilder: AppBuilder) {
        self.appBuilder = appBuilder
    }

    // MARK: - Public Functions

    func setRootViewController(view: UIViewController) {
        rootController = UINavigationController(rootViewController: view)
    }

    func moveToRecipeListScreen(category: DishCategory) {
        let recipeListModule = appBuilder.makeRecipeListModule(coordinator: self)
        recipeListModule.presenter?.setCategory(category: category)
        rootController?.pushViewController(recipeListModule, animated: true)
    }

    func popToAllRecipes() {
        rootController?.popViewController(animated: true)
    }

    func pushToDetail(recipeUri: String) {
        let recipeDetailModule = appBuilder.makeRecipeDetailModule(coordinator: self, recipeUri: recipeUri)
        rootController?.pushViewController(recipeDetailModule, animated: true)
    }
}
