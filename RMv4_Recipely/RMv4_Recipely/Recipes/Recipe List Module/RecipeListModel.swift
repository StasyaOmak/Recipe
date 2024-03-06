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
struct RecipeDescription: Equatable {
    /// тип рецепта
    let type: RecipeCategories
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
            type: .fish, title: "Simple Fish And Corn",
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
            type: .fish, title: "Some fish",
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
            type: .fish, title: "Another Fish",
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
            type: .fish, title: "More fish",
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
            type: .fish, title: "MORE FIIIIISHHH",
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

    /// свойство типа с мок-данными
    static let soupRecipes: [RecipeDescription] = [
        RecipeDescription(
            type: .soup, title: "Tomato soup",
            imageName: "soup",
            time: 30,
            value: 1000,
            weight: 793,
            carbohydrates: 10.78,
            fats: 10.00,
            proteins: 97.30,
            descriptions: Constants.descriptions
        ),
        RecipeDescription(
            type: .soup, title: "Tom yum",
            imageName: "soup",
            time: 15,
            value: 1555,
            weight: 793,
            carbohydrates: 10.78,
            fats: 10.00,
            proteins: 97.30,
            descriptions: Constants.descriptions
        ),
        RecipeDescription(
            type: .soup, title: "Cheese soup",
            imageName: "soup",
            time: 60,
            value: 1322,
            weight: 793,
            carbohydrates: 10.78,
            fats: 10.00,
            proteins: 97.30,
            descriptions: Constants.descriptions
        ),
        RecipeDescription(
            type: .soup, title: "Seafood soup",
            imageName: "soup",
            time: 15,
            value: 1000,
            weight: 793,
            carbohydrates: 10.78,
            fats: 10.00,
            proteins: 97.30,
            descriptions: Constants.descriptions
        ),
        RecipeDescription(
            type: .soup, title: "Borshch",
            imageName: "soup",
            time: 35,
            value: 1000,
            weight: 793,
            carbohydrates: 10.78,
            fats: 10.00,
            proteins: 97.30,
            descriptions: Constants.descriptions
        )
    ]

    static let dessertRecipes: [RecipeDescription] = [
        RecipeDescription(
            type: .desserts,
            title: "Chocolate cookies",
            imageName: "desserts",
            time: 60,
            value: 10,
            weight: 100,
            carbohydrates: 11.2,
            fats: 11.2,
            proteins: 11.2,
            descriptions: Constants.descriptions
        ),
        RecipeDescription(
            type: .desserts,
            title: "Berty Botts Beans",
            imageName: "desserts",
            time: 60,
            value: 10,
            weight: 100,
            carbohydrates: 11.2,
            fats: 11.2,
            proteins: 11.2,
            descriptions: Constants.descriptions
        ),
        RecipeDescription(
            type: .desserts,
            title: "Napoleon Cake",
            imageName: "desserts",
            time: 60,
            value: 10,
            weight: 100,
            carbohydrates: 11.2,
            fats: 11.2,
            proteins: 11.2,
            descriptions: Constants.descriptions
        )
    ]

    static let allRecipes: [RecipeDescription] = soupRecipes + fishRecipes + dessertRecipes
    /// свойство типа с избранными рецептами
    static var favoritesRecipes: [RecipeDescription] = []

    /// метод типа для получения данных
    static func getRecipes(category: DishCategory) -> [RecipeDescription] {
        RecipeDescription.allRecipes.filter { $0.type == category.type }
    }
}
