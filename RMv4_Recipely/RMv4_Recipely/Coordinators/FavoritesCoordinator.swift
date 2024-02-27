// FavoritesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// координатор модуля избранное
final class FavoritesCoordinator: BaseCoordinator {
    let rootController: UINavigationController

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }
}
