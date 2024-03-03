// RecipeListModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Содержание рецепта для таблицы
struct RecipeDescription: Equatable {
    /// название
    let title: String
    /// название картинки
    let imageName: String
    /// время приготовления
    let time: Int
    /// калорийность
    let value: Int
    /// находится ли в избранном
    var isFavorite: Bool = false

    /// свойство типа с мок-данными
    static var fishRecipes: [RecipeDescription] = [
        RecipeDescription(title: "Fish", imageName: "recipe", time: 60, value: 245),
        RecipeDescription(title: "Some fish", imageName: "recipe", time: 60, value: 245),
        RecipeDescription(title: "Another Fish", imageName: "recipe", time: 60, value: 245),
        RecipeDescription(title: "More fish", imageName: "recipe", time: 60, value: 245),
        RecipeDescription(title: "MORE FIIIIISHHH", imageName: "recipe", time: 60, value: 245)
    ]

    /// свойство типа с мок-данными
    static let otherRecipes: [RecipeDescription] = [
        RecipeDescription(title: "Some meal", imageName: "recipe", time: 45, value: 300),
        RecipeDescription(title: "Dessert", imageName: "desserts", time: 20, value: 450)
    ]
    /// свойство типа с мок-данными избранные рецепты
    static var favoritesRecipes: [RecipeDescription] = [
        RecipeDescription(title: "Dessert", imageName: "desserts", time: 20, value: 450, isFavorite: true)
    ]

    /// метод типа для получения данных
    static func getRecipes(category: DishCategory) -> [RecipeDescription] {
        switch category.type {
        case .fish:
            return RecipeDescription.fishRecipes
        default:
            return RecipeDescription.otherRecipes
        }
    }
}
