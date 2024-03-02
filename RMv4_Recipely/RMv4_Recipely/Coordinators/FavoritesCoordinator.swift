// FavoritesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор модуля "избранное"
final class FavoritesCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var rootController: UINavigationController?

    // MARK: - Public Functions

    func setRootViewController(view: UIViewController) {
        rootController = UINavigationController(rootViewController: view)
    }
}
