// AuthCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана авторизации
final class AuthCoordinator: BaseCoordinator {
    // MARK: - Types

    // swiftlint:disable custom_custom_void_handler
    typealias VoidHandler = () -> ()
    // swiftlint:enable custom_custom_void_handler

    // MARK: - Public Properties

    var rootViewController: UINavigationController?

    var onFinishFlow: VoidHandler?

    // MARK: - Public Methods

    override func start() {
        showAuth()
    }

    func onFinish() {
        onFinishFlow?()
    }

    func showAuth() {
        let authViewController = AuthViewController()
        let authPresenter = AuthPresenter()
        authViewController.presenter = authPresenter
        authPresenter.view = authViewController
        authPresenter.authCoordinator = self

        let rootViewController = UINavigationController(rootViewController: authViewController)
        setAsRoot​(​_​: rootViewController)
        self.rootViewController = rootViewController
    }

    func moveToNextController() {
        let authViewController = AuthViewController()
        rootViewController?.pushViewController(authViewController, animated: true)
    }
}
