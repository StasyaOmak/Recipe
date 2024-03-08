// AppBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Создание модулей для приложения
final class AppBuilder {
    // MARK: - Private Properties

    private let loggerManager: LoggerManagerProtocol

    // MARK: - Initializers

    init(loggerManager: LoggerManagerProtocol) {
        self.loggerManager = loggerManager
    }

    // инит на логгер и приватное свойство

    // TODO: - баг, при возврате из рецептов в таб бар тайтлы таббара игнорируют кастомный цвет (кроме "recipes")

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

    func makeRecipeDetailModule(coordinator: RecipesCoordinator, recipe: RecipeDescription) -> RecipeDetailView {
        let view = RecipeDetailView()
        let presenter = RecipeDetailPresenter(
            coordinator: coordinator,
            view: view,
            recipe: recipe,
            loggerManager: loggerManager
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
            loggerManager: loggerManager
        )
        recipeListView.presenter = recipeListPresenter
        return recipeListView
    }
}
