// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главный координатор для приложения
final class AppCoordinator: BaseCoordinator {
    // MARK: - Private Properties

    private var tabBarController: TabBarController?
    private let builder: AppBuilder

    // MARK: - Initializers

    init(builder: AppBuilder) {
        self.builder = builder
    }

    // MARK: - Public Methods

    override func start() {
//        toMain()
        toAuth()
    }

    // MARK: - Private Methods

    private func toMain() {
        tabBarController = TabBarController()
        guard let tabBarViewController = tabBarController else { return }

        let recipesCoordinator = RecipesCoordinator(appBuilder: builder)
        let recipesModuleView = builder.makeRecipesModule(coordinator: recipesCoordinator)
        recipesCoordinator.setRootViewController(view: recipesModuleView)
        add(coordinator: recipesCoordinator)
        guard let recipesView = recipesCoordinator.rootController else { return }

        let profileCoordinator = ProfileCoordinator(appBuilder: builder)
        let profileModuleView = builder.makeProfileModule(coordinator: profileCoordinator)
        profileCoordinator.setRootViewController(view: profileModuleView)
        add(coordinator: profileCoordinator)
        guard let profileView = profileCoordinator.rootController else { return }
        profileCoordinator.onFinishFlow = { [weak self] in
            self?.remove(coordinator: profileCoordinator)
            self?.toAuth()
        }

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
