// FullRecipe.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель полного описания рецепта
struct FullRecipe {
    /// Название рецепта
    let label: String?
    /// Имя изображения рецепта
    let imageName: String?
    /// Общий вес ингредиентов рецепта
    let totalWeight: Int
    /// Общее время приготовления рецепта в минутах
    let totalTime: Int
    /// Общее количество калорий в рецепте
    let totalCalories: Int
    /// Общее количество сахара в рецепте
    let totalSugars: Int
    /// Общее количество белка в рецепте
    let totalProtein: Int
    /// Общее количество жира в рецепте
    let totalFat: Int
    /// Список ингредиентов рецепта
    let ingredients: [String]?
    /// Идентификатор ресурса
    let recipeURI: String

    init(dto: RecipeDTO) {
        label = dto.label
        imageName = dto.image
        totalWeight = Int(dto.totalWeight?.rounded() ?? 0)
        totalTime = dto.totalTime ?? 0
        totalCalories = Int(dto.totalNutrients?[NutrientsDTO.enercKcal]?.quantity.rounded() ?? 0)
        totalSugars = Int(dto.totalNutrients?[NutrientsDTO.sugars]?.quantity.rounded() ?? 0)
        totalProtein = Int(dto.totalNutrients?[NutrientsDTO.proteins]?.quantity.rounded() ?? 0)
        totalFat = Int(dto.totalNutrients?[NutrientsDTO.fat]?.quantity.rounded() ?? 0)
        ingredients = dto.ingredientLines
        recipeURI = dto.uri ?? ""
    }

    init(coreDataType: Recipe) {
        label = coreDataType.label
        imageName = coreDataType.imageName
        totalWeight = Int(coreDataType.totalWeight)
        totalTime = Int(coreDataType.totalTime)
        totalCalories = Int(coreDataType.totalCalories)
        totalSugars = Int(coreDataType.totalSugars)
        totalProtein = Int(coreDataType.totalProtein)
        totalFat = Int(coreDataType.totalFat)
        ingredients = []
        recipeURI = coreDataType.recipeURI
    }
}
