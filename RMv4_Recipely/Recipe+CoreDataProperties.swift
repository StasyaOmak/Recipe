// Recipe+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

/// Полный рецепт для CoreData
public extension Recipe {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Recipe> {
        NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged var label: String?
    @NSManaged var totalWeight: Int64
    @NSManaged var totalTime: Int64
    @NSManaged var totalCalories: Int64
    @NSManaged var totalSugars: Int64
    @NSManaged var totalProtein: Int64
    @NSManaged var totalFat: Int64
//    @NSManaged var ingredients: [String]
    @NSManaged var imageName: String?
    @NSManaged var recipeURI: String
}

extension Recipe: Identifiable {}
