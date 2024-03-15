// AppBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Создание модулей для приложения
final class AppBuilder {
    // MARK: - Private Properties

    private let loggerManager: LoggerManagerProtocol
    private let networkService: NetworkServiceProtocol
    private let imageLoader: LoadImageServiceProtocol

    // MARK: - Initializers

    init(
        loggerManager: LoggerManagerProtocol,
        networkService: NetworkServiceProtocol,
        imageLoader: LoadImageServiceProtocol
    ) {
        self.loggerManager = loggerManager
        self.networkService = networkService
        self.imageLoader = imageLoader
    }

    // MARK: - Public Methods

    func makeProfileModule(coordinator: ProfileCoordinator) -> ProfileViewController {
        let profileView = ProfileViewController()
        let profilePresenter = ProfilePresenter(view: profileView, coordinator: coordinator)
        profileView.presenter = profilePresenter
        profileView.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage.profile,
            selectedImage: UIImage.profileFill.withRenderingMode(.alwaysOriginal)
        )
        profileView.tabBarItem.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.createColor(114, 186, 191, 1)],
            for: .selected
        )
        return profileView
    }

    func makeRecipeDetailModule(coordinator: RecipesCoordinator, recipeUri: String) -> RecipeDetailView {
        let view = RecipeDetailView()
        let presenter = RecipeDetailPresenter(
            coordinator: coordinator,
            view: view,
            loggerManager: loggerManager,
            networkService: networkService,
            imageLoader: imageLoader
        )
        view.presenter = presenter
        return view
    }

    func makeRecipesModule(coordinator: RecipesCoordinator) -> RecipesViewController {
        let recipesView = RecipesViewController()
        let recipesPresenter = RecipesPresenter(
            view: recipesView,
            coordinator: coordinator,
            loggerManager: loggerManager
        )
        recipesView.recipesPresenter = recipesPresenter
        recipesView.tabBarItem = UITabBarItem(
            title: "Recipes",
            image: UIImage.cake,
            selectedImage: UIImage.cakeFill.withRenderingMode(.alwaysOriginal)
        )
        recipesView.tabBarItem.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.createColor(114, 186, 191, 1)],
            for: .selected
        )
        return recipesView
    }

    func makeFavoritesModule(coordinator: FavoritesCoordinator) -> FavoritesViewController {
        let favoritesView = FavoritesViewController()
        let favoritesPresenter = FavoritesPresenter(favoritesView: favoritesView, favoritesCoordinator: coordinator)
        favoritesView.presenter = favoritesPresenter
        favoritesView.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage.bookmark,
            selectedImage: UIImage.bookmarkFill.withRenderingMode(.alwaysOriginal)
        )

        favoritesView.tabBarItem.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.createColor(114, 186, 191, 1)],
            for: .selected
        )
        return favoritesView
    }

    func makeBonusesModule(coordinator: ProfileCoordinator) -> BonusesViewController {
        let bonusesView = BonusesViewController()
        let bonusesPresenter = BonusesPresenter(bonusesView: bonusesView, coordinator: coordinator)
        bonusesView.bonusesPresenter = bonusesPresenter

        let sheet = bonusesView.sheetPresentationController
        sheet?.detents = [.custom(resolver: { _ in
            355
        })]

        sheet?.prefersGrabberVisible = true
        sheet?.preferredCornerRadius = 30
        return bonusesView
    }

    func makeRecipeListModule(coordinator: RecipesCoordinator) -> RecipeListViewController {
        let recipeListView = RecipeListViewController()
        let recipeListPresenter = RecipeListPresenter(
            view: recipeListView,
            coordinator: coordinator,
            loggerManager: loggerManager,
            networkService: networkService
        )
        recipeListView.presenter = recipeListPresenter
        return recipeListView
    }
}
