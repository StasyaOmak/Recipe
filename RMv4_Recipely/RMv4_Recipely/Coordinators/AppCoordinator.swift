// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главный координатор для приложения
final class AppCoordinator: BaseCoordinator {
    // MARK: - Private Properties

    private var tabBarController: TabBarController?
    let builder = AppBuilder()

    /// переопределяем старт. отсюда у нас две точки входа в приложение, либо авторизация пройдена, либо нет
    /// пока нужно вручную откомментировать нужную для входа
    override func start() {
//        toAuth()
        toMain()
    }

    // MARK: - Private Methods

    private func toMain() {
        tabBarController = TabBarController()
        guard let tabBarViewController = tabBarController else { return }

        let recipesModuleView = builder.makeRecipesModule()
        let recipesCoordinator = RecipesCoordinator(rootController: recipesModuleView)
        recipesModuleView.recipesPresenter?.coordinator = recipesCoordinator
        add(coordinator: recipesCoordinator)

        let profileModuleView = builder.makeProfileModule()
        let profileCoordinator = ProfileCoordinator(rootController: profileModuleView)
        profileModuleView.presenter?.coordinator = profileCoordinator
        add(coordinator: profileCoordinator)

        let favoritesModuleView = builder.makeFavoritesModule()
        let favoritesCoordinator = FavoritesCoordinator(rootController: favoritesModuleView)
        favoritesModuleView.favoritesPresenter?.favoritesCoordinator = favoritesCoordinator
        add(coordinator: favoritesCoordinator)

        tabBarViewController.setViewControllers(
            [recipesCoordinator.rootController, favoritesCoordinator.rootController, profileCoordinator.rootController],
            animated: false
        )
        setAsRoot​(​_​: tabBarViewController)
    }

    private func toAuth() {
        let authCoordinator = AuthCoordinator()
        authCoordinator.onFinishFlow = { [weak self] in
            self?.remove(coordinator: authCoordinator)
            self?.toMain()
        }
        add(coordinator: authCoordinator)
        authCoordinator.start()
    }
}
