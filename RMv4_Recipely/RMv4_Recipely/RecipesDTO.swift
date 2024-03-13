// RecipesDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель краткого описания рецепта
struct ShortRecipe {
    // Имя изображения рецепта
    let imageName: String
    // название рецепта
    let label: String
    // Общее время приготовления рецепта в минутах
    let totalTime: Int
    // Количество калорий
    let calories: Double
    // URI рецепта
    let uri: String

    init(dto: RecipeDTO) {
        imageName = dto.image
        label = dto.label
        totalTime = dto.totalTime
        calories = dto.calories.rounded()
        uri = dto.uri
    }
}

/// Модель полного описания рецепта
struct FullRecipe {
    // Название рецепта
    let label: String
    // Имя изображения рецепта
    let imageName: String
    // Общий вес ингредиентов рецепта
    let totalWeight: Double
    // Общее время приготовления рецепта в минутах
    let totalTime: Int
    // Общее количество калорий в рецепте
    let totalCalories: Double
    // Общее количество сахара в рецепте
    let totalSugars: Double
    // Общее количество белка в рецепте
    let totalProtein: Double
    // Общее количество жира в рецепте
    let totalFat: Double
    // Список ингредиентов рецепта
    let ingredients: [String]

    init(dto: RecipeDTO) {
        label = dto.label
        imageName = dto.image
        totalWeight = dto.totalWeight
        totalTime = dto.totalTime
        totalCalories = dto.totalNutrients[Nutrients.enercKcal]?.quantity ?? 0
        totalSugars = dto.totalNutrients[Nutrients.sugars]?.quantity ?? 0
        totalProtein = dto.totalNutrients[Nutrients.proteins]?.quantity ?? 0
        totalFat = dto.totalNutrients[Nutrients.fat]?.quantity ?? 0
        ingredients = dto.ingredientLines
    }
}

/// Перечисление для пищевых компонентов
enum Nutrients {
    // Калории
    static let enercKcal = "ENERC_KCAL"
    // Жиры
    static let fat = "FAT"
    // Сахара
    static let sugars = "CHOCDF"
    // Белки
    static let proteins = "PROCNT"
}

/// Структура DTO
struct HitsDTO: Codable {
    // Массив объектов HitDTO
    let hits: [HitDTO]
    // Ключ для массива hits в JSON
    enum CodingKeys: String, CodingKey {
        case hits
    }
}

// MARK: - Hit

/// DTO хита
struct HitDTO: Codable {
    // Рецепт
    let recipe: RecipeDTO
}

/// DTO рецепта
struct RecipeDTO: Codable {
    // Уникальный идентификатор рецепта
    let uri: String
    // Название рецепта
    let label: String
    // Ссылка на изображение рецепта
    let image: String
    // Дополнительные изображения
    let images: Images
    // Источник рецепта
    let source: Source
    // Ссылка на страницу с рецептом
    let url: String
    // Ссылка для поделиться рецептом
    let shareAs: String
    // Количество порций
    let yield: Int
    // Метки здоровья
    let healthLabels: [String]
    // Список ингредиентов
    let ingredientLines: [String]
    // Дополнительная информация о ингредиентах
    let ingredients: [Ingredient]
    // Количество калорий
    let calories, totalCO2Emissions: Double
    // Класс выбросов CO2
    let co2EmissionsClass: String
    // Общий вес ингредиентов
    let totalWeight: Double
    // Общее время приготовления
    let totalTime: Int
    // Тип кухни
    let cuisineType: [String]
    // Тип приема пищи
    let mealType: [MealType]
    // Тип блюда
    let dishType: [DishType]
    // Общие пищевые компоненты
    let totalNutrients, totalDaily: [String: Total]
    // Дайджест о рецепте
    let digest: [Digest]
    // Теги рецепта
    let tags: [String]?
}


// MARK: - Digest

/// DTO для пищевых веществ
struct Digest: Codable {
    let label: Label
    let tag: String
    let schemaOrgTag: SchemaOrgTag?
    let total: Double
    let hasRDI: Bool
    let daily: Double
    let unit: Unit
    let sub: [Digest]?
}

/// Перечисление для меток
enum Label: String, Codable {
    // Кальций
    case calcium = "Calcium"
    // Углеводы (net)
    case carbohydratesNet = "Carbohydrates (net)"
    // Углеводы
    case carbs = "Carbs"
    // Углеводы (net)
    case carbsNet = "Carbs (net)"
    // Холестерин
    case cholesterol = "Cholesterol"
    // Энергия
    case energy = "Energy"
    // Жиры
    case fat = "Fat"
    // Пищевые волокна
    case fiber = "Fiber"
    // Фолат эквивалентный (total)
    case folateEquivalentTotal = "Folate equivalent (total)"
    // Фолат (food)
    case folateFood = "Folate (food)"
    // Фолиевая кислота
    case folicAcid = "Folic acid"
    // Железо
    case iron = "Iron"
    // Магний
    case magnesium = "Magnesium"
    // Мононенасыщенные жиры
    case monounsaturated = "Monounsaturated"
    // Ниацин (B3)
    case niacinB3 = "Niacin (B3)"
    // Фосфор
    case phosphorus = "Phosphorus"
    // Полиненасыщенные жиры
    case polyunsaturated = "Polyunsaturated"
    // Калий
    case potassium = "Potassium"
    // Белки
    case protein = "Protein"
    // Рибофлавин (B2)
    case riboflavinB2 = "Riboflavin (B2)"
    // Насыщенные жиры
    case saturated = "Saturated"
    // Натрий
    case sodium = "Sodium"
    // Сахарные алкоголи
    case sugarAlcohols = "Sugar alcohols"
    // Сахар
    case sugars = "Sugars"
    // Добавленный сахар
    case sugarsAdded = "Sugars, added"
    // Тиамин (B1)
    case thiaminB1 = "Thiamin (B1)"
    // Транс-жиры
    case trans = "Trans"
    // Витамин A
    case vitaminA = "Vitamin A"
    // Витамин B12
    case vitaminB12 = "Vitamin B12"
    // Витамин B6
    case vitaminB6 = "Vitamin B6"
    // Витамин C
    case vitaminC = "Vitamin C"
    // Витамин D
    case vitaminD = "Vitamin D"
    // Витамин E
    case vitaminE = "Vitamin E"
    // Витамин K
    case vitaminK = "Vitamin K"
    // Вода
    case water = "Water"
    // Цинк
    case zinc = "Zinc"
}

/// Перечисление для меток схемы
enum SchemaOrgTag: String, Codable {
    case carbohydrateContent
    case cholesterolContent
    case fatContent
    case fiberContent
    case proteinContent
    case saturatedFatContent
    case sodiumContent
    case sugarContent
    case transFatContent
}

/// Перечисление для единиц измерения
enum Unit: String, Codable {
    case empty = "%"
    case g
    case kcal
    case mg
    case µg
}

/// Перечисление для типов блюд
enum DishType: String, Codable {
    case salad
}

// MARK: - Images

/// DTO для изображений
struct Images: Codable {
    let thumbnail, small, regular: Large
    let large: Large?

    enum CodingKeys: String, CodingKey {
        case thumbnail = "THUMBNAIL"
        case small = "SMALL"
        case regular = "REGULAR"
        case large = "LARGE"
    }
}

// MARK: - Large

/// Структура для больших изображений
struct Large: Codable {
    let url: String
    let width, height: Int
}

/// DTO для ингредиентов
struct Ingredient: Codable {
    let text: String
    let quantity: Double
    let measure: String?
    let food: String
    let weight: Double
    let foodCategory, foodID: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case text, quantity, measure, food, weight, foodCategory
        case foodID = "foodId"
        case image
    }
}

/// Перечисление для типов приемов пищи
enum MealType: String, Codable {
    case breakfast
    case lunchDinner = "lunch/dinner"
}

/// Перечисление для источников
enum Source: String, Codable {
    case notWithoutSalt = "Not Without Salt"
    case seriousEats = "Serious Eats"
    case smittenKitchen = "Smitten Kitchen"
    case tartelette = "Tartelette"
}

// MARK: - Total

/// DTO для суммарных значений
struct Total: Codable {
    let label: Label
    let quantity: Double
    let unit: Unit
}
