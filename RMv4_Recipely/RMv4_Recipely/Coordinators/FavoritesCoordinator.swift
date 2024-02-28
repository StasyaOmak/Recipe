// FavoritesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор модуля "избранное"
final class FavoritesCoordinator: BaseCoordinator {
    
    // MARK: - Public Properties

    let rootController: UINavigationController
    
    // MARK: - Initializers

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }
}
