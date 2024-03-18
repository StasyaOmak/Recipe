// ShortRecipeEntity+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

/// Сокращённый  рецепт для CoreData
public extension ShortRecipeEntity {
    @nonobjc class func fetchRequest() -> NSFetchRequest<ShortRecipeEntity> {
        NSFetchRequest<ShortRecipeEntity>(entityName: "ShortRecipeEntity")
    }

    @NSManaged var imageName: String?
    @NSManaged var label: String?
    @NSManaged var totalTime: Int64
    @NSManaged var calories: Int64
    @NSManaged var uri: String?
    @NSManaged var dishType: String
}

extension ShortRecipeEntity: Identifiable {}
