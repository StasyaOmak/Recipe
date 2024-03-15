// FullRecipe.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель полного описания рецепта
struct FullRecipe {
    // Название рецепта
    let label: String?
    // Имя изображения рецепта
    let imageName: String?
    // Общий вес ингредиентов рецепта
    let totalWeight: Double?
    // Общее время приготовления рецепта в минутах
    let totalTime: Int?
    // Общее количество калорий в рецепте
    let totalCalories: Double
    // Общее количество сахара в рецепте
    let totalSugars: Double
    // Общее количество белка в рецепте
    let totalProtein: Double
    // Общее количество жира в рецепте
    let totalFat: Double
    // Список ингредиентов рецепта
    let ingredients: [String]?

    init(dto: RecipeDTO) {
        label = dto.label
        imageName = dto.image
        totalWeight = dto.totalWeight
        totalTime = dto.totalTime
        totalCalories = dto.totalNutrients?[NutrientsDTO.enercKcal]?.quantity ?? 0
        totalSugars = dto.totalNutrients?[NutrientsDTO.sugars]?.quantity ?? 0
        totalProtein = dto.totalNutrients?[NutrientsDTO.proteins]?.quantity ?? 0
        totalFat = dto.totalNutrients?[NutrientsDTO.fat]?.quantity ?? 0
        ingredients = dto.ingredientLines
    }
}
