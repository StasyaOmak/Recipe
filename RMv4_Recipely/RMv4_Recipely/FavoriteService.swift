// FavoriteService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// сервис для избранного
final class FavoriteService {
    // MARK: - Public Properties

    static let shared = FavoriteService()

    // MARK: - Private Properties

    private let userDefaults = UserDefaults.standard
    private let key = "Favorites"

    // MARK: - Public Methods

    func getFavorites() -> [RecipeDescription] {
        guard let data = FavoriteService.shared.userDefaults.data(forKey: key) else { return [] }
        do {
            let favorites = try JSONDecoder().decode([RecipeDescription].self, from: data)
            return favorites
        } catch {
            return []
        }
    }

    func save(_ recipe: [RecipeDescription]) {
        do {
            let data = try JSONEncoder().encode(recipe)
            FavoriteService.shared.userDefaults.set(data, forKey: key)
        } catch {}
    }

    func addFavorite(_ recipe: RecipeDescription) {
        var favorites = getFavorites()
        favorites.append(recipe)
        save(favorites)
    }

    @discardableResult
    func removeFavorite(_ index: Int) -> RecipeDescription {
        var favorites = getFavorites()
        let removeFavorite = favorites.remove(at: index)
        save(favorites)
        return removeFavorite
    }
}
