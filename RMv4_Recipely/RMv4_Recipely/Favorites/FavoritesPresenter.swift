// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс презентера модуля "Избранные рецепты"
protocol FavoritesPresenterProtocol {
    var favoritesCoordinator: FavoritesCoordinator? { get set }
}

/// Презентер модуля "Избранные рецепты"
class FavoritesPresenter {
    weak var favoritesView: FavoritesViewController?
    weak var favoritesCoordinator: FavoritesCoordinator?
}

/// Расширение презентера  методами протокола
extension FavoritesPresenter: FavoritesPresenterProtocol {}
