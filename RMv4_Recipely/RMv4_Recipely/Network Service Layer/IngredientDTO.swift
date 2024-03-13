// IngredientDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// DTO для ингредиентов
struct Ingredient: Codable {
    /// текст ингредиента
    let text: String
    /// количество
    let quantity: Double
    /// единицы измерения
    let measure: String?
    /// продукт
    let food: String
    /// вес
    let weight: Double
    /// категория продукта и id
    let foodCategory, foodID: String
    /// изображение
    let image: String

    /// ключи для парсинга в DTO
    enum CodingKeys: String, CodingKey {
        case text, quantity, measure, food, weight, foodCategory
        case foodID = "foodId"
        case image
    }
}
