// RecipeDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// DTO рецепта
struct RecipeDTO: Codable {
    /// Уникальный идентификатор рецепта
    let uri: String
    /// Название рецепта
    let label: String
    /// Ссылка на изображение рецепта
    let image: String
    /// Дополнительные изображения
    let images: ImageDTO
    /// Ссылка на страницу с рецептом
    let url: String
    /// Ссылка для поделиться рецептом
    let shareAs: String
    /// Количество порций
    let yield: Int
    /// Метки здоровья
    let healthLabels: [String]
    /// Список ингредиентов
    let ingredientLines: [String]
    /// Дополнительная информация о ингредиентах
    let ingredients: [IngredientDTO]
    /// Количество калорий
    let calories, totalCO2Emissions: Double
    /// Класс выбросов CO2
    let co2EmissionsClass: String
    /// Общий вес ингредиентов
    let totalWeight: Double
    /// Общее время приготовления
    let totalTime: Int
    /// Тип кухни
    let cuisineType: [String]
    /// Тип блюда
    let dishType: [DishType]
    /// Общие пищевые компоненты
    let totalNutrients, totalDaily: [String: TotalDTO]
    /// Дайджест о рецепте
    let digest: [DigestDTO]
    /// Теги рецепта
    let tags: [String]?
}
