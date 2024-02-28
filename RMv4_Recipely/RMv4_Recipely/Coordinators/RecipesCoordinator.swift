// RecipesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор модуля "Рецепты"
final class RecipesCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var rootController: UINavigationController

    // MARK: - Initializers

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }
}
