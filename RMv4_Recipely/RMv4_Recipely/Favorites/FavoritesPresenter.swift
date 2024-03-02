// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс презентера модуля "Избранные рецепты"
protocol FavoritesPresenterProtocol: AnyObject {}

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

/// Расширение презентера  методами протокола
extension FavoritesPresenter: FavoritesPresenterProtocol {}
