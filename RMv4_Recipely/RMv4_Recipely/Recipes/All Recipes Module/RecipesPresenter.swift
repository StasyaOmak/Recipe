// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс презентера модуля "рецепты"
protocol RecipesPresenterProtocol {
    var coordinator: RecipesCoordinator? { get set }

    init(view: RecipesViewControllerProtocol)
    func getInfo(categoryNumber: Int) -> DishCategory
    func getCategoryCount() -> Int
    func goToCategory(_ category: RecipeCategories)
}

/// Презентер модуля "рецепты"
final class RecipesPresenter: RecipesPresenterProtocol {
    // MARK: - Public Properties

    weak var view: RecipesViewControllerProtocol?
    weak var coordinator: RecipesCoordinator?

    required init(view: RecipesViewControllerProtocol) {
        self.view = view
    }

    // MARK: - Private Properties

    private let informationSource = InformationSource()

    // MARK: - Public Methods

    func getInfo(categoryNumber: Int) -> DishCategory {
        informationSource.categories[categoryNumber]
    }

    func getCategoryCount() -> Int {
        informationSource.categories.count
    }

    func goToCategory(_ category: RecipeCategories) {}
}
