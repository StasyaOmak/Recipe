// RecipeListPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс презентера модуля "Рецепты выбранной категории"
protocol RecipeListPresenterProtocol: AnyObject {
    /// Метод установки категории на экран
    func setCategory(category: DishCategory)
    /// Метод-флаг возврата на прдыдущий экран
    func popToAllRecipes()
    /// метод-флаг нажатия на кнопку фильтра
    func filterButtonPressed(sender: FilterButton)
    /// Переход к детальному отображению
    func pushToDetail(recipe: RecipeDescription)
    /// Поиск рецептов по запросу
    func searchRecipes(withText text: String)
    /// Проверка поиска
    func checkSearch() -> [RecipeDescription]
    /// Cмена свойства на true
    func startSearch()
    /// Cмена свойства на false
    func stopSearch()
}

/// Презентер модуля "Рецепты выбранной категории"
final class RecipeListPresenter {
    // MARK: - Private Properties

    private weak var view: RecipeListViewControllerProtocol?
    private weak var coordinator: RecipesCoordinator?

    private var sourceOfRecepies: [RecipeDescription] = []
    private var isSearching = false
    private var searchedRecipes: [RecipeDescription] = []

    // MARK: - Initializers

    init(view: RecipeListViewControllerProtocol, coordinator: RecipesCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}

// MARK: - RecipeListPresenter + RecipeListPresenterProtocol

extension RecipeListPresenter: RecipeListPresenterProtocol {
    func stopSearch() {
        isSearching = false
    }

    func startSearch() {
        isSearching = true
    }

    func checkSearch() -> [RecipeDescription] {
        if isSearching {
            return searchedRecipes
        } else {
            return sourceOfRecepies
        }
    }

    func setCategory(category: DishCategory) {
        let title = category.type.rawValue.capitalized
        view?.setTitle(title)
        let recipes = RecipeDescription.getRecipes(category: category)
        sourceOfRecepies = recipes
        view?.setRecipes(recipes)
    }

    func popToAllRecipes() {
        coordinator?.popToAllRecipes()
    }

    func filterButtonPressed(sender: FilterButton) {
        if sender.isPressed == false {
            view?.disableAllFilterButtons()
            sender.isPressed = !sender.isPressed
        } else {
            sender.isPressed = true
            sender.isInIncreaseOrder = !sender.isInIncreaseOrder
            sender.isInDecreaseOrder = !sender.isInDecreaseOrder
        }
    }

    func pushToDetail(recipe: RecipeDescription) {
        coordinator?.pushToDetail(recipe: recipe)
    }

    func searchRecipes(withText text: String) {
        guard !text.isEmpty else {
            isSearching = false
            searchedRecipes = []
            view?.reloadTableView()
            return
        }
        isSearching = true
        searchedRecipes = sourceOfRecepies.filter { $0.title.lowercased().contains(text.lowercased()) }
        view?.reloadTableView()
    }
}
