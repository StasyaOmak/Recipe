// AuthCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана авторизации
final class AuthCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var rootViewController: UINavigationController?

    var onFinishFlow: (() -> ())?

    // MARK: - Public Methods

    override func start() {
        showAuth()
        // здесь что-то происходит при переходе на экран
    }

    func onFinish() {
        onFinishFlow?()
    }

    func showAuth() {
        // injection
        // для тренировки можно написать билдер и вынести инъекции туда
        let authViewController = AuthViewController()
        let authPresenter = AuthPresenter()
        authViewController.presenter = authPresenter
        authPresenter.view = authViewController
        authPresenter.authCoordinator = self

        // making root controller
        let rootViewController = UINavigationController(rootViewController: authViewController)
        setAsRoot​(​_​: rootViewController)
        self.rootViewController = rootViewController
    }

    func moveToNextController() {
        let authViewController = AuthViewController()
        rootViewController?.pushViewController(authViewController, animated: true)
    }
}
