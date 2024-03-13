// LabelDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Перечисление для меток
enum LabelDTO: String, Codable {
    /// Кальций
    case calcium = "Calcium"
    /// Углеводы (net)
    case carbohydratesNet = "Carbohydrates (net)"
    /// Углеводы
    case carbs = "Carbs"
    /// Углеводы (net)
    case carbsNet = "Carbs (net)"
    /// Холестерин
    case cholesterol = "Cholesterol"
    /// Энергия
    case energy = "Energy"
    /// Жиры
    case fat = "Fat"
    /// Пищевые волокна
    case fiber = "Fiber"
    /// Фолат эквивалентный (total)
    case folateEquivalentTotal = "Folate equivalent (total)"
    /// Фолат (food)
    case folateFood = "Folate (food)"
    /// Фолиевая кислота
    case folicAcid = "Folic acid"
    /// Железо
    case iron = "Iron"
    /// Магний
    case magnesium = "Magnesium"
    /// Мононенасыщенные жиры
    case monounsaturated = "Monounsaturated"
    /// Ниацин (B3)
    case niacinB3 = "Niacin (B3)"
    /// Фосфор
    case phosphorus = "Phosphorus"
    /// Полиненасыщенные жиры
    case polyunsaturated = "Polyunsaturated"
    /// Калий
    case potassium = "Potassium"
    /// Белки
    case protein = "Protein"
    /// Рибофлавин (B2)
    case riboflavinB2 = "Riboflavin (B2)"
    /// Насыщенные жиры
    case saturated = "Saturated"
    /// Натрий
    case sodium = "Sodium"
    /// Сахарные алкоголи
    case sugarAlcohols = "Sugar alcohols"
    /// Сахар
    case sugars = "Sugars"
    /// Добавленный сахар
    case sugarsAdded = "Sugars, added"
    /// Тиамин (B1)
    case thiaminB1 = "Thiamin (B1)"
    /// Транс-жиры
    case trans = "Trans"
    /// Витамин A
    case vitaminA = "Vitamin A"
    /// Витамин B12
    case vitaminB12 = "Vitamin B12"
    /// Витамин B6
    case vitaminB6 = "Vitamin B6"
    /// Витамин C
    case vitaminC = "Vitamin C"
    /// Витамин D
    case vitaminD = "Vitamin D"
    /// Витамин E
    case vitaminE = "Vitamin E"
    /// Витамин K
    case vitaminK = "Vitamin K"
    /// Вода
    case water = "Water"
    /// Цинк
    case zinc = "Zinc"
}
