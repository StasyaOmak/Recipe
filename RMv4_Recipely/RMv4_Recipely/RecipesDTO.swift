// RecipesDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель краткого описания рецепта
struct ShortRecipe {
    let imageName: String
    let label: String
    let totalTime: Int
    let calories: Double
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
    let label: String
    let imageName: String
    let totalWeight: Double
    let totalTime: Int
    let totalCalories: Double
    let totalSugars: Double
    let totalProtein: Double
    let totalFat: Double
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
    static let enercKcal = "ENERC_KCAL"
    static let fat = "FAT"
    static let sugars = "CHOCDF"
    static let proteins = "PROCNT"
}

/// Структура DTO
struct HitsDTO: Codable {
    let hits: [HitDTO]

    enum CodingKeys: String, CodingKey {
        case hits
    }
}

// MARK: - Hit

/// DTO хита
struct HitDTO: Codable {
    let recipe: RecipeDTO
}

/// DTO рецепта
struct RecipeDTO: Codable {
    let uri: String
    let label: String
    let image: String
    let images: Images
    let url: String
    let shareAs: String
    let yield: Int
    let healthLabels: [String]
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let calories, totalCO2Emissions: Double
    let co2EmissionsClass: String
    let totalWeight: Double
    let totalTime: Int
    let cuisineType: [String]
    let dishType: [DishType]
    let totalNutrients, totalDaily: [String: Total]
    let tags: [String]?
}

/// Перечисление для меток
enum Label: String, Codable {
    case calcium = "Calcium"
    case carbohydratesNet = "Carbohydrates (net)"
    case carbs = "Carbs"
    case carbsNet = "Carbs (net)"
    case cholesterol = "Cholesterol"
    case energy = "Energy"
    case fat = "Fat"
    case fiber = "Fiber"
    case folateEquivalentTotal = "Folate equivalent (total)"
    case folateFood = "Folate (food)"
    case folicAcid = "Folic acid"
    case iron = "Iron"
    case magnesium = "Magnesium"
    case monounsaturated = "Monounsaturated"
    case niacinB3 = "Niacin (B3)"
    case phosphorus = "Phosphorus"
    case polyunsaturated = "Polyunsaturated"
    case potassium = "Potassium"
    case protein = "Protein"
    case riboflavinB2 = "Riboflavin (B2)"
    case saturated = "Saturated"
    case sodium = "Sodium"
    case sugarAlcohols = "Sugar alcohols"
    case sugars = "Sugars"
    case sugarsAdded = "Sugars, added"
    case thiaminB1 = "Thiamin (B1)"
    case trans = "Trans"
    case vitaminA = "Vitamin A"
    case vitaminB12 = "Vitamin B12"
    case vitaminB6 = "Vitamin B6"
    case vitaminC = "Vitamin C"
    case vitaminD = "Vitamin D"
    case vitaminE = "Vitamin E"
    case vitaminK = "Vitamin K"
    case water = "Water"
    case zinc = "Zinc"
}

/// Перечисление для единиц измерения
enum Unit: String, Codable {
    case empty = "%"
    // swiftlint:disable identifier_name
    /// граммы
    case g
    // swiftlint:enable identifier_name
    /// килокалории
    case kcal
    /// миллиграммы
    case mg
    /// микрограммы
    case µg
}

/// Перечисление для типов блюд
enum DishType: String, Codable {
    /// салат
    case salad
    /// первое блюдо
    case soup
    /// второе блюдо?
    case mainCourse = "Main course"
    /// панкейки
    case pancake
    /// напитки
    case drinks
    /// десерты
    case desserts
}

// MARK: - Images

/// DTO для изображений
struct Images: Codable {
    /// типы изображений - заглушка, маленькое, обычное
    let thumbnail, small, regular: Large
    /// большое изображение
    let large: Large?

    /// ключи для парсинга в DTO
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
    /// ссылка на изображение
    let url: String
    /// параметры ширины и высоты
    let width, height: Int
}

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

// MARK: - Total

// DTO для суммарных значений
struct Total: Codable {
    /// название лейбла
    let label: Label
    /// числовой параметр лейбла
    let quantity: Double
    /// единицы измерения и другие суффиксы
    let unit: Unit
}
