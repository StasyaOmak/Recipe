// RecipeListModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// MARK: - Constants

private enum Constants {
    static let descriptions = """
    1/2 to 2 fish heads, depending on size, about 5 pounds total
    2 tablespoons vegetable oil
    1/4 cup red or green thai curry paste
    3 tablespoons fish sauce or anchovy sauce
    1 tablespoon sugar
    1 can coconut milk, about 12 ounces
    3 medium size asian eggplants, cut int 1 inch rounds
    Handful of bird's eye chilies
    1/2 cup thai basil leaves
    Juice of 3 limes
    1/2 to 2 fish heads, depending on size, about 5 pounds total
    2 tablespoons vegetable oil
    1/4 cup red or green thai curry paste
    3 tablespoons fish sauce or anchovy sauce
    1 tablespoon sugar
    1 can coconut milk, about 12 ounces
    3 medium size asian eggplants, cut int 1 inch rounds
    Handful of bird's eye chilies
    1/2 cup thai basil leaves
    Juice of 3 limes
    1/2 to 2 fish heads, depending on size, about 5 pounds total
    2 tablespoons vegetable oil
    1/4 cup red or green thai curry paste
    3 tablespoons fish sauce or anchovy sauce
    1 tablespoon sugar
    1 can coconut milk, about 12 ounces
    3 medium size asian eggplants, cut int 1 inch rounds
    Handful of bird's eye chilies
    1/2 cup thai basil leaves
    Juice of 3 limes
    """
}

/// Содержание рецепта для таблицы
struct RecipeDescription {
    /// название
    let title: String
    /// название картинки
    let imageName: String
    /// время приготовления
    let time: Int
    /// калорийность
    let value: Int
    /// Вес
    let weight: Int
    /// Углеводы
    let carbohydrates: Float
    /// Жиры
    let fats: Float
    /// Белки
    let proteins: Float
    /// Описание рецепта
    let descriptions: String

    /// свойство типа с мок-данными
    static let fishRecipes: [RecipeDescription] = [
        RecipeDescription(
            title: "Simple Fish And Corn",
            imageName: "recipe",
            time: 60,
            value: 1322,
            weight: 793,
            carbohydrates: 10.78,
            fats: 10.00,
            proteins: 97.30,
            descriptions: Constants.descriptions
        ),
        RecipeDescription(
            title: "Some fish",
            imageName: "recipe",
            time: 60,
            value: 1322,
            weight: 793,
            carbohydrates: 10.78,
            fats: 10.00,
            proteins: 97.30,
            descriptions: Constants.descriptions
        ),
        RecipeDescription(
            title: "Another Fish",
            imageName: "recipe",
            time: 60,
            value: 1322,
            weight: 793,
            carbohydrates: 10.78,
            fats: 10.00,
            proteins: 97.30,
            descriptions: Constants.descriptions
        ),
        RecipeDescription(
            title: "More fish",
            imageName: "recipe",
            time: 60,
            value: 1322,
            weight: 793,
            carbohydrates: 10.78,
            fats: 10.00,
            proteins: 97.30,
            descriptions: Constants.descriptions
        ),
        RecipeDescription(
            title: "MORE FIIIIISHHH",
            imageName: "recipe",
            time: 60,
            value: 1322,
            weight: 793,
            carbohydrates: 10.78,
            fats: 10.00,
            proteins: 97.30,
            descriptions: Constants.descriptions
        ),
    ]

    static let otherRecipes: [RecipeDescription] = [
        RecipeDescription(
            title: "Some meal",
            imageName: "recipe",
            time: 60,
            value: 1322,
            weight: 793,
            carbohydrates: 10.78,
            fats: 10.00,
            proteins: 97.30,
            descriptions: Constants.descriptions
        ),
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
