// RecipeDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// DTO рецепта
struct RecipeDTO: Codable {
    /// Уникальный идентификатор рецепта
    let uri: String?
    /// Название рецепта
    let label: String?
    /// Ссылка на изображение рецепта
    let image: String?
    /// Ссылка на страницу с рецептом
    let url: String?
    /// Список ингредиентов
    let ingredientLines: [String]?
    /// Общий вес ингредиентов
    let totalWeight: Double?
    /// Общее время приготовления
    let totalTime: Int?
    /// Общие пищевые компоненты
    let totalNutrients, totalDaily: [String: TotalDTO]?
//    /// dishType
//    let dishType: DishType
}
