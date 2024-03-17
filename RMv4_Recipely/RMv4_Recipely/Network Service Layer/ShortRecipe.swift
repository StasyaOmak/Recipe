// ShortRecipe.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель краткого описания рецепта
struct ShortRecipe {
    /// Имя изображения рецепта
    let imageName: String?
    /// название рецепта
    let label: String?
    /// Общее время приготовления рецепта в минутах
    let totalTime: Int
    /// Количество калорий
    var calories: Int
    /// URI рецепта
    let uri: String?

    init(dto: RecipeDTO) {
        imageName = dto.image
        label = dto.label
        totalTime = dto.totalTime ?? 0
        calories = Int(dto.totalNutrients?[NutrientsDTO.enercKcal]?.quantity.rounded() ?? 0)
        uri = dto.uri
    }
}
