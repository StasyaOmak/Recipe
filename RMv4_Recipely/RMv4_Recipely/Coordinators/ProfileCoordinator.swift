// ProfileCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор модуля "Профиль"
final class ProfileCoordinator: BaseCoordinator {
    // MARK: - Types

    // swiftlint:disable custom_custom_void_handler
    typealias VoidHandler = () -> ()
    // swiftlint:enable custom_custom_void_handler

    // MARK: - Public Properties

    var rootController: UINavigationController

    var onFinishFlow: VoidHandler?

    // MARK: - Private Properties

    private var appBuilder = AppBuilder()

    // MARK: - Initializers

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }

    // MARK: - Public Methods

    func logOut() {
        onFinishFlow?()
    }

    func moveToBonusesScreen() {
        let bonusesModule = appBuilder.makeBonusesModule()
        bonusesModule.bonusesPresenter?.coordinator = self
        rootController.present(bonusesModule, animated: true)
    }

    func dismissBonusesScreen() {
        rootController.dismiss(animated: true)
    }
}
