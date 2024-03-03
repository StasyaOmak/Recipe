// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс презентера модуля "Избранные рецепты"
protocol FavoritesPresenterProtocol: AnyObject {
    func checkIfFavouritesEmpty()
    func getFavouritesCount() -> Int
    func getFavourites() -> [RecipeDescription]
    func removeFromFavourites(recipeIndex: Int)
}

/// Презентер модуля "Избранные рецепты"
final class FavoritesPresenter {
    // MARK: - Private Properties

    private weak var favoritesView: FavoritesViewControllerProtocol?
    private weak var favoritesCoordinator: FavoritesCoordinator?

    // MARK: - Initializers

    init(favoritesView: FavoritesViewController, favoritesCoordinator: FavoritesCoordinator) {
        self.favoritesView = favoritesView
        self.favoritesCoordinator = favoritesCoordinator
    }
}

// MARK: - FavoritesPresenter + FavoritesPresenterProtocol
extension FavoritesPresenter: FavoritesPresenterProtocol {
    func removeFromFavourites(recipeIndex: Int) {
        let recipe = RecipeDescription.favoritesRecipes.remove(at: recipeIndex)
        for var item in RecipeDescription.otherRecipes where item == recipe {
            item.isFavorite = false
        }
    }

    func getFavourites() -> [RecipeDescription] {
        RecipeDescription.favoritesRecipes
    }

    func checkIfFavouritesEmpty() {
        if RecipeDescription.favoritesRecipes.isEmpty {
            favoritesView?.setEmptyState()
        } else {
            favoritesView?.setNonEmptyState()
        }
    }

    func getFavouritesCount() -> Int {
        RecipeDescription.favoritesRecipes.count
    }
}
