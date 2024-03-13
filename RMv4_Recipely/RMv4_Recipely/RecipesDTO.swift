//
//  RecipesDTO.swift
//  RMv4_Recipely
//
//  Created by Anastasiya Omak on 12/03/2024.
//


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
    let source: Source
    let url: String
    let shareAs: String
    let yield: Int
    let dietLabels: [DietLabel]
    let healthLabels: [String]
    let cautions: [Caution]
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let calories, totalCO2Emissions: Double
    let co2EmissionsClass: String
    let totalWeight: Double
    let totalTime: Int
    let cuisineType: [String]
    let mealType: [MealType]
    let dishType: [DishType]
    let totalNutrients, totalDaily: [String: Total]
    let digest: [Digest]
    let tags: [String]?
}

/// Перечисление для предупреждений
enum Caution: String, Codable {
    case gluten = "Gluten"
    case sulfites = "Sulfites"
    case wheat = "Wheat"
}

/// Перечисление для диетических меток
enum DietLabel: String, Codable {
    case balanced = "Balanced"
    case highFiber = "High-Fiber"
    case lowCarb = "Low-Carb"
    case lowFat = "Low-Fat"
    case lowSodium = "Low-Sodium"
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
