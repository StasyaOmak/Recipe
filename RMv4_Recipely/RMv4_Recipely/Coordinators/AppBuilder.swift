// AppBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Создание модулей для приложения
final class AppBuilder {
    // MARK: - Constants

    private enum Constants {
        //    static let
        //    static let
        //    static let
        //    static let
    }

    // MARK: - IBOutlets

    // MARK: - Visual Components

    // MARK: - Public Properties

    // MARK: - Private Properties

    // MARK: - Initializers

    // MARK: - Life Cycle

    // MARK: - Public Methods

    func makeProfileModule() -> ProfileViewController {
        let profileView = ProfileViewController()
        let profilePresenter = ProfilePresenter()
        profileView.presenter = profilePresenter
        profilePresenter.view = profileView
        profileView.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage.profile,
            selectedImage: UIImage.profileFill.withRenderingMode(.alwaysOriginal)
        )
        profileView.tabBarItem.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.basicGreen],
            for: .selected
        )
        return profileView
    }

    func makeRecipesModule() -> RecipesViewController {
        let recipesView = RecipesViewController()
        let recipesPresenter = RecipesPresenter()
        recipesView.recipesPresenter = recipesPresenter
        recipesPresenter.view = recipesView
        recipesView.tabBarItem = UITabBarItem(
            title: "Recipes",
            image: UIImage.cake,
            selectedImage: UIImage.cakeFill.withRenderingMode(.alwaysOriginal)
        )
        recipesView.tabBarItem.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.basicGreen],
            for: .selected
        )
        return recipesView
    }

    func makeFavoritesModule() -> FavoritesViewController {
        let favoritesView = FavoritesViewController()
        let favoritesPresenter = FavoritesPresenter()
        favoritesView.favoritesPresenter = favoritesPresenter
        favoritesPresenter.favoritesView = favoritesView
        favoritesView.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage.bookmark,
            selectedImage: UIImage.bookmarkFill.withRenderingMode(.alwaysOriginal)
        )
        favoritesView.tabBarItem.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.basicGreen],
            for: .selected
        )
        return favoritesView
    }

    // MARK: - IBAction

    // MARK: - Private Methods
}
