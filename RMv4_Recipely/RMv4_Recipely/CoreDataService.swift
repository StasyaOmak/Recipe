// CoreDataService.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import UIKit

final class CoreDataService: NSObject {
    static let shared = CoreDataService()
    override private init() {}

    lazy var context: NSManagedObjectContext = persistentContainer.viewContext

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RMv4_Recipely")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext() {
//        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func createFullRecipe(recipe: FullRecipe) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Recipe", in: context) else { return }

        let recipeToSave = Recipe(entity: entityDescription, insertInto: context)

        recipeToSave.label = recipe.label
        recipeToSave.totalWeight = Int64(recipe.totalWeight)
        recipeToSave.totalTime = Int64(recipe.totalTime)
        recipeToSave.totalCalories = Int64(recipe.totalCalories)
        recipeToSave.totalSugars = Int64(recipe.totalSugars)
        recipeToSave.totalProtein = Int64(recipe.totalProtein)
        recipeToSave.totalFat = Int64(recipe.totalFat)
//        recipeToSave.ingredients = recipe.ingredients ?? []
        recipeToSave.imageName = recipe.imageName
        recipeToSave.recipeURI = recipe.recipeURI

        saveContext()
    }

    func createShortRecipe(recipes: [ShortRecipe], category: DishCategory) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "ShortRecipeEntity", in: context)
        else { return }
        for element in recipes {
            let recipe = ShortRecipeEntity(entity: entityDescription, insertInto: context)

            recipe.label = element.label
            recipe.totalTime = Int64(element.totalTime)
            recipe.imageName = element.imageName
            recipe.calories = Int64(element.calories)
            recipe.uri = element.uri
            recipe.dishType = category.type.rawValue

            saveContext()
        }
    }

    func fetchFullRecipe(uri: String) -> FullRecipe? {
        do {
            guard let recipe = try? context.fetch(Recipe.fetchRequest()) else { return nil }
            guard let filtredRecipe = recipe.first(where: { $0.recipeURI == uri }) else { return nil }
            return FullRecipe(coreDataType: filtredRecipe)
        }
    }

    func fetchShortRecipes(dishType: DishCategory) -> [ShortRecipe] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ShortRecipeEntity")
        do {
            guard let recipe = try? context.fetch(fetchRequest) as? [ShortRecipeEntity] else { return [] }
            let filtredRecipe = recipe.filter { $0.dishType == dishType.type.rawValue }
            let aaa = filtredRecipe.map { ShortRecipe(coreDataObject: $0)
            }
            return aaa
        }
    }
}
