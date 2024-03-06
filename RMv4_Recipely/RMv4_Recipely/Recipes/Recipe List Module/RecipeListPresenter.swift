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
    /// метод перехода в экран с описанием рецепта
    func pushToDetail(recipe: RecipeDescription)
    /// метод смены состояния загрузки
    func changeState()
    /// Поиск рецептов по запросу
    func searchRecipes(withText text: String)
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
    private var category: DishCategory?

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
    func searchRecipes(withText text: String) {
        guard !text.isEmpty else {
            isSearching = false
            searchedRecipes = []
            view?.reloadTableView()
            return
        }
        isSearching = true
        searchedRecipes = sourceOfRecepies.filter { $0.title.lowercased().contains(text.lowercased()) }
        view?.setRecipes(searchedRecipes)
    }

    func stopSearch() {
        isSearching = false
    }

    func startSearch() {
        isSearching = true
        view?.setRecipes(searchedRecipes)
    }

    func setCategory(category: DishCategory) {
        sourceOfRecepies = RecipeDescription.getRecipes(category: category)
        let title = category.type.rawValue.capitalized
        view?.setTitle(title)
        self.category = category
        var recipes: [RecipeDescription] = []
        if isSearching {
            recipes = searchedRecipes
        } else {
            recipes = sourceOfRecepies
        }
        view?.setRecipes(recipes)
    }

    func popToAllRecipes() {
        coordinator?.popToAllRecipes()
    }

    func changeState() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.view?.nextState()
        }
    }

    func filterButtonPressed(sender: FilterButton) {
        if sender.isPressed == false {
            sender.isPressed = !sender.isPressed
            sender.isInIncreaseOrder = true
            sender.isInDecreaseOrder = false
            switch sender.tag {
            case 0:
                caloriesButtonTriggered(sender: sender)
            case 1:
                timeButtonTriggered(sender: sender)
            default:
                break
            }
        } else {
            switch sender.tag {
            case 0:
                caloriesButtonTriggered(sender: sender)
            case 1:
                timeButtonTriggered(sender: sender)
            default:
                break
            }
        }
    }

    func pushToDetail(recipe: RecipeDescription) {
        coordinator?.pushToDetail(recipe: recipe)
    }

    private func caloriesButtonTriggered(sender: FilterButton) {
        guard let anotherFilterState = view?.checkAnotherFilter(sender: sender) else { return }
        sender.isPressed = true
        if sender.isInIncreaseOrder {
            sender.isInIncreaseOrder = false
            sender.isInDecreaseOrder = true
            if anotherFilterState.isPressed {
                switch anotherFilterState.increasing {
                case true:
                    let recipes = sourceOfRecepies.sorted {
                        if $0.value == $1.value {
                            $0.time < $1.time
                        } else {
                            $0.value < $1.value
                        }
                    }
                    view?.setRecipes(recipes)
                case false:
                    let recipes = sourceOfRecepies.sorted {
                        if $0.value == $1.value {
                            $0.time > $1.time
                        } else {
                            $0.value < $1.value
                        }
                    }
                    view?.setRecipes(recipes)
                }
            } else {
                let recipes = sourceOfRecepies.sorted { $0.value < $1.value }
                view?.setRecipes(recipes)
            }
        } else {
            sender.isInIncreaseOrder = true
            sender.isInDecreaseOrder = false
            if anotherFilterState.isPressed {
                switch anotherFilterState.increasing {
                case true:
                    let recipes = sourceOfRecepies.sorted {
                        if $0.value == $1.value {
                            $0.time < $1.time
                        } else {
                            $0.value > $1.value
                        }
                    }
                    view?.setRecipes(recipes)
                case false:
                    let recipes = sourceOfRecepies.sorted {
                        if $0.value == $1.value {
                            $0.time > $1.time
                        } else {
                            $0.value > $1.value
                        }
                    }
                    view?.setRecipes(recipes)
                }
            } else {
                let recipes = sourceOfRecepies.sorted { $0.value > $1.value }
                view?.setRecipes(recipes)
            }
        }
    }

    private func timeButtonTriggered(sender: FilterButton) {
        guard let category, let anotherFilterState = view?.checkAnotherFilter(sender: sender) else { return }
        sender.isPressed = true
        if sender.isInIncreaseOrder {
            sender.isInIncreaseOrder = false
            sender.isInDecreaseOrder = true
            if anotherFilterState.isPressed {
                switch anotherFilterState.increasing {
                case true:
                    let recipes = RecipeDescription.getRecipes(category: category).sorted {
                        if $0.time == $1.time {
                            $0.value < $1.value
                        } else {
                            $0.time < $1.time
                        }
                    }
                    view?.setRecipes(recipes)
                case false:
                    let recipes = RecipeDescription.getRecipes(category: category).sorted {
                        if $0.time == $1.time {
                            $0.value > $1.value
                        } else {
                            $0.time < $1.time
                        }
                    }
                    view?.setRecipes(recipes)
                }
            } else {
                let recipes = RecipeDescription.getRecipes(category: category).sorted { $0.time < $1.time }
                view?.setRecipes(recipes)
            }
        } else {
            sender.isInIncreaseOrder = true
            sender.isInDecreaseOrder = false
            if anotherFilterState.isPressed {
                switch anotherFilterState.increasing {
                case true:
                    let recipes = RecipeDescription.getRecipes(category: category).sorted {
                        if $0.time == $1.time {
                            $0.value < $1.value
                        } else {
                            $0.time > $1.time
                        }
                    }
                    view?.setRecipes(recipes)
                case false:
                    let recipes = RecipeDescription.getRecipes(category: category).sorted {
                        if $0.time == $1.time {
                            $0.value > $1.value
                        } else {
                            $0.time > $1.time
                        }
                    }
                    view?.setRecipes(recipes)
                }
            } else {
                let recipes = RecipeDescription.getRecipes(category: category).sorted { $0.time > $1.time }
                view?.setRecipes(recipes)
            }
        }
    }
}
