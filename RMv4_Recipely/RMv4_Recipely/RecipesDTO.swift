// RecipesDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// маленькая модель рецепта
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

/// полная модель рецепта
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

/// Nutrients
enum Nutrients {
    static let enercKcal = "ENERC_KCAL"
    static let fat = "FAT"
    static let sugars = "CHOCDF"
    static let proteins = "PROCNT"
}

/// Upper level dto
struct HitsDTO: Codable {
    let hits: [HitDTO]

    enum CodingKeys: String, CodingKey {
        case hits
    }
}

// MARK: - Hit

/// HitDTO
struct HitDTO: Codable {
    let recipe: RecipeDTO
}

/// RecipeDTO
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

/// Caution
enum Caution: String, Codable {
    case gluten = "Gluten"
    case sulfites = "Sulfites"
    case wheat = "Wheat"
}

/// DietLabel
enum DietLabel: String, Codable {
    case balanced = "Balanced"
    case highFiber = "High-Fiber"
    case lowCarb = "Low-Carb"
    case lowFat = "Low-Fat"
    case lowSodium = "Low-Sodium"
}

// MARK: - Digest

/// Digest
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

/// Label
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

/// ghghg
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

/// ghghg
enum Unit: String, Codable {
    case empty = "%"
    // swiftlint:disable identifier_name
    case g
    // swiftlint:enable identifier_name
    case kcal
    case mg
    case µg
}

/// ghghg
enum DishType: String, Codable {
    case salad = "Salad"
    case soup = "Soup"
}

// MARK: - Images

/// ghghg
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

/// image size
struct Large: Codable {
    let url: String
    let width, height: Int
}

/// ghghg
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

/// ghghg
enum MealType: String, Codable {
    case breakfast
    case lunchDinner = "lunch/dinner"
}

/// ghghg
enum Source: String, Codable {
    case notWithoutSalt = "Not Without Salt"
    case seriousEats = "Serious Eats"
    case smittenKitchen = "Smitten Kitchen"
    case tartelette = "Tartelette"
}

// MARK: - Total

/// ghghg
struct Total: Codable {
    let label: Label
    let quantity: Double
    let unit: Unit
}
