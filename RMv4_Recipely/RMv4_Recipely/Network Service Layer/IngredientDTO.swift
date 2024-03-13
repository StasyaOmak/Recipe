// IngredientDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// DTO для ингредиентов
struct IngredientDTO: Codable {
    /// Текст ингредиента
    let text: String
    /// Количество
    let quantity: Double
    /// Единицы измерения
    let measure: String?
    /// Продукт
    let food: String
    /// Вес
    let weight: Double
    /// Категория продукта и id
    let foodCategory, foodID: String
    /// Изображение
    let image: String

    /// Ключи для парсинга в DTO
    enum CodingKeys: String, CodingKey {
        case text, quantity, measure, food, weight, foodCategory
        case foodID = "foodId"
        case image
    }
}
