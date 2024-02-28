// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс презентера модуля "рецепты"
protocol RecipesPresenterProtocol {
    var coordinator: RecipesCoordinator? { get set }
}

/// Презентер модуля "рецепты"
final class RecipesPresenter {
    weak var view: RecipesViewControllerProtocol?
    weak var coordinator: RecipesCoordinator?
}

/// Расширение презентера  методами протокола
extension RecipesPresenter: RecipesPresenterProtocol {}
