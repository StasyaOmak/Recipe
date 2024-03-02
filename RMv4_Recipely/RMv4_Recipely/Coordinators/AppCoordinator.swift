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

        let recipesCoordinator = RecipesCoordinator()
        let recipesModuleView = builder.makeRecipesModule(coordinator: recipesCoordinator)
        recipesCoordinator.setRootViewController(view: recipesModuleView)
        add(coordinator: recipesCoordinator)
        guard let recipesView = recipesCoordinator.rootController else { return }

        let profileCoordinator = ProfileCoordinator()
        let profileModuleView = builder.makeProfileModule(coordinator: profileCoordinator)
        profileCoordinator.setRootViewController(view: profileModuleView)
        add(coordinator: profileCoordinator)
        guard let profileView = profileCoordinator.rootController else { return }

        let favoritesCoordinator = FavoritesCoordinator()
        let favoritesModuleView = builder.makeFavoritesModule(coordinator: favoritesCoordinator)
        favoritesCoordinator.setRootViewController(view: favoritesModuleView)
        add(coordinator: favoritesCoordinator)
        guard let favoritesView = favoritesCoordinator.rootController else { return }

        tabBarViewController.setViewControllers(
            [recipesView, favoritesView, profileView],
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
