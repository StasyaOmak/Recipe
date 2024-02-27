// BaseCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Базовый класс-координатор приложения, открытый для наследования
class BaseCoordinator {
    // MARK: - Public Properties

    var childCoordinators: [BaseCoordinator] = []

    // MARK: - Public Methods

    func start() {
        fatalError("child должен быть реализован")
    }

    func add(coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
    }

    func remove(coordinator: BaseCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }

    func setAsRoot​(​_​ controller: UIViewController) {
        let window = UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .last { $0.isKeyWindow }
        window?.rootViewController = controller
    }
}
