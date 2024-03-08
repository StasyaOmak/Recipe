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

    var rootController: UINavigationController?

    var onFinishFlow: VoidHandler?

    // MARK: - Private Properties

    private var appBuilder: AppBuilder

    // MARK: - Initializers

    init(appBuilder: AppBuilder) {
        self.appBuilder = appBuilder
    }

    // MARK: - Public Methods

    func setRootViewController(view: UIViewController) {
        rootController = UINavigationController(rootViewController: view)
    }

    func logOut() {
        onFinishFlow?()
    }

    func moveToBonusesScreen(user: User) {
        let bonusesModule = appBuilder.makeBonusesModule(coordinator: self)
        bonusesModule.bonusesPresenter?.setUserInfo(user: user)
        rootController?.present(bonusesModule, animated: true)
    }

    func moveToTermsOfUseScreen() {}

    func dismissBonusesScreen() {
        rootController?.dismiss(animated: true)
    }
}
