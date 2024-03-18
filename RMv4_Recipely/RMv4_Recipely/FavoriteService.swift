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

    func getFavorites() -> [ShortRecipe] {
        guard let data = FavoriteService.shared.userDefaults.data(forKey: key) else { return [] }
        do {
            let favorites = try JSONDecoder().decode([ShortRecipe].self, from: data)
            return favorites
        } catch {
            return []
        }
    }

    func save(_ recipe: [ShortRecipe]) {
        do {
            let data = try JSONEncoder().encode(recipe)
            FavoriteService.shared.userDefaults.set(data, forKey: key)
        } catch {}
    }

    func addFavorite(_ recipe: ShortRecipe) {
        var favorites = getFavorites()
        favorites.append(recipe)
        save(favorites)
    }

    @discardableResult
    func removeFavorite(_ index: Int) -> ShortRecipe {
        var favorites = getFavorites()
        let removeFavorite = favorites.remove(at: index)
        save(favorites)
        return removeFavorite
    }
}
