// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс презентера модуля "рецепты"
protocol RecipesPresenterProtocol: AnyObject {
    /// Получить информацию о категории
    func getInfo(categoryNumber: Int) -> DishCategory
    /// Получить количество категорий
    func getCategoryCount() -> Int
    /// Перейти к категории
    func goToCategory(_ category: DishCategory)
    /// Изменить состояние
    func changeState()
    /// Отправить лог
    func sendLog(message: LogAction)

    /// Инициализатор презентера
    init(view: RecipesViewControllerProtocol, coordinator: RecipesCoordinator, loggerManager: LoggerManagerProtocol)
}

/// Презентер модуля "рецепты"
final class RecipesPresenter: RecipesPresenterProtocol {
    // MARK: - Private Properties

    private weak var view: RecipesViewControllerProtocol?
    private weak var coordinator: RecipesCoordinator?
    private let informationSource = InformationSource()
    private var loggerManager: LoggerManagerProtocol?

    // MARK: - Initializers

    init(view: RecipesViewControllerProtocol, coordinator: RecipesCoordinator, loggerManager: LoggerManagerProtocol) {
        self.view = view
        self.coordinator = coordinator
        self.loggerManager = loggerManager
    }

    // MARK: - Public Methods

    func sendLog(message: LogAction) {
        loggerManager?.log(message)
    }

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
        view?.setState(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.view?.setState(.success)
        }
    }
}
