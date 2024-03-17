// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// TODO: принимаемые параметры в методы для категории и рецепта
// TODO: переделать перечисление со стейтами, нужен принимаемый параметр
/// протокол-интерфейс сервиса работы с сетью
protocol NetworkServiceProtocol {
    /// получение всех рецептов
    /// - Parameters:
    /// - dishType: Тип блюда, приходит по нажатию из ячейки
    /// - health: параметры для Vegetarian
    /// - query: параметр для поиска и для основных блюд
    /// - completion: замыкание, возвращающее результат запроса и ошибки
    func getRecipes(
        dishType: DishCategory,
        health: String?,
        query: String?,
        completion: @escaping (Result<[ShortRecipe], NetworkError>) -> ()
    )
    /// получение отдельного рецепта
    /// - Parameters:
    /// - recipeUri: ссылка на конкретный рецепт, приходит по тапу на ячейку таблицы
    /// - completion: замыкание, возвращающее результат запроса и ошибки
    func getSingleRecipe(recipeUri: String, completion: @escaping (Result<FullRecipe?, NetworkError>) -> ())
}

/// Сервис для работы с сетевыми запросами
final class NetworkService: NetworkServiceProtocol {
    // MARK: - Private Properties

    private let recipesDecoder = ResultDecoder<[ShortRecipe]> { data in
        do {
            let hitsDTO = try JSONDecoder().decode(HitsDTO.self, from: data)
            return hitsDTO.hits.map { ShortRecipe(dto: $0.recipe) }
        } catch {
            return []
        }
    }

    private let singleRecipeDecoder = ResultDecoder<FullRecipe?> { data in
        let hitsDTO = try JSONDecoder().decode(HitsDTO.self, from: data)
        guard let recipeDTO = hitsDTO.hits.first?.recipe else { return nil }
        return FullRecipe(dto: recipeDTO)
    }

    // MARK: - Public Methods

    func getRecipes(
        dishType: DishCategory,
        health: String?,
        query: String?,
        completion: @escaping (Result<[ShortRecipe], NetworkError>) -> ()
    ) {
        guard let urlRequest = createAllRecipesUrlRequest(
            dishType: dishType,
            health: health,
            query: query
        )
        else { return }

        let task = URLSession.shared.dataTask(with: urlRequest) { result in
            completion(self.recipesDecoder.decode(result))
        }
        task.resume()
    }

    func getSingleRecipe(
        recipeUri: String,
        completion: @escaping (Result<FullRecipe?, NetworkError>) -> ()
    ) {
        guard let urlRequest = makeSingleRecipeUrlRequest(recipeUri: recipeUri) else { return }
        let task = URLSession.shared.dataTask(with: urlRequest) { result in
            completion(self.singleRecipeDecoder.decode(result))
        }
        task.resume()
    }
}
