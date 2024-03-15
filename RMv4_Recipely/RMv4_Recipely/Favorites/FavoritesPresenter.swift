// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс презентера модуля "Избранные рецепты"
protocol FavoritesPresenterProtocol: AnyObject {
    /// метод проверки, пуст ли массив с избранными рецептами
    func checkIfFavouritesEmpty()
    /// метод возвращает число элементов в избранном
    func getFavouritesCount() -> Int
    /// метод возвращает массив избранных рецептов
    func getFavourites() -> [ShortRecipe]
    /// метод удаляет элемент из избранного
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
        let recipe = FavoriteService.shared.removeFavorite(recipeIndex)
        for var item in RecipeDescription.allRecipes where item == recipe {
            item.isFavorite = false
        }
    }

    func getFavourites() -> [ShortRecipe] {
//        FavoriteService.shared.getFavorites()
        []
    }

    func checkIfFavouritesEmpty() {
        if FavoriteService.shared.getFavorites().isEmpty {
            favoritesView?.setEmptyState()
        } else {
            favoritesView?.setNonEmptyState()
        }
    }

    func getFavouritesCount() -> Int {
        FavoriteService.shared.getFavorites().count
    }
}
