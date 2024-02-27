// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol FavoritesPresenterProtocol {
    var favoritesCoordinator: FavoritesCoordinator? { get set }
}

/// Презентер модуля "Избранные рецепты"
class FavoritesPresenter {
    weak var favoritesView: FavoritesViewController?
    weak var favoritesCoordinator: FavoritesCoordinator?
}

extension FavoritesPresenter: FavoritesPresenterProtocol {}
