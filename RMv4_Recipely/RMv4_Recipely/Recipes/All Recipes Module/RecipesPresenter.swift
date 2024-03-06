// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс презентера модуля "рецепты"
protocol RecipesPresenterProtocol: AnyObject {
    func getInfo(categoryNumber: Int) -> DishCategory
    func getCategoryCount() -> Int
    func goToCategory(_ category: DishCategory)
    func changeState()
}

/// Презентер модуля "рецепты"
final class RecipesPresenter: RecipesPresenterProtocol {
    // MARK: - Private Properties

    private weak var view: RecipesViewControllerProtocol?
    private weak var coordinator: RecipesCoordinator?
    private let informationSource = InformationSource()

    // MARK: - Initializers

    init(view: RecipesViewControllerProtocol, coordinator: RecipesCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }

    // MARK: - Public Methods

    func getInfo(categoryNumber: Int) -> DishCategory {
        InformationSource.categories[categoryNumber]
    }

    func getCategoryCount() -> Int {
        InformationSource.categories.count
    }

    func goToCategory(_ category: DishCategory) {
        coordinator?.moveToRecipeListScreen(category: category)
    }

    func changeState() {
        view?.nextState(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.view?.nextState(.success)
        }
    }
}
