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
        dishType: String,
        health: String?,
        query: String?,
        completion: @escaping (Result<[ShortRecipe]?, Error>) -> ()
    )
    /// получение отдельного рецепта
    /// - Parameters:
    /// - recipeUri: ссылка на конкретный рецепт, приходит по тапу на ячейку таблицы
    /// - completion: замыкание, возвращающее результат запроса и ошибки
    func getSingleRecipe(recipeUri: String, completion: @escaping (Result<FullRecipe?, Error>) -> ())
}

/// Сервис для работы с сетевыми запросами
final class NetworkService: NetworkServiceProtocol {
    // MARK: - Constants

    private enum URLComponentConstants {
        static let scheme = "https"
        static let host = "api.edamam.com"
        static let allRecipesPath = "/api/recipes/v2"
        static let recipePath = "/api/recipes/v2/by-uri"
        static let idName = "app_id"
        static let id = "e57eb06e"
        static let keyName = "app_key"
        static let key = "64c3439c7a6a028f377473ed43eea52a"
        static let typeName = "type"
        static let type = "public"
        static let dishTypeName = "dishType"
        static let healthName = "health"
        static let queryName = "q"
        static let uriName = "uri"
        static let uri = "http://www.edamam.com/ontologies/edamam.owl#recipe_e074fb5e814ed30309780398e68c2b90"
    }

    // MARK: - Private Properties

    private var components = URLComponents()

    private var urlQueryItems: [URLQueryItem] = [
        .init(name: URLComponentConstants.typeName, value: URLComponentConstants.type),
        .init(name: URLComponentConstants.idName, value: URLComponentConstants.id),
        .init(name: URLComponentConstants.keyName, value: URLComponentConstants.key),
    ]

    // MARK: - Public Methods

    func getRecipes(
        dishType: String = DishType.salad.rawValue,
        health: String?,
        query: String?,
        completion: @escaping (Result<[ShortRecipe]?, Error>) -> ()
    ) {
        // TODO: построение урл выделить куда-то в метод
        components.scheme = URLComponentConstants.scheme
        components.host = URLComponentConstants.host
        components.path = URLComponentConstants.allRecipesPath
        urlQueryItems.append(.init(name: URLComponentConstants.dishTypeName, value: dishType))
        components.queryItems = urlQueryItems

        if let health {
            urlQueryItems.append(.init(name: URLComponentConstants.healthName, value: health))
        }

        if let query {
            urlQueryItems.append(.init(name: URLComponentConstants.queryName, value: query))
        }

        guard let url = components.url else { return }
        let urlRequest = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, _ in
            if let data = data {
                do {
                    let recipesDTO = try JSONDecoder().decode(HitsDTO.self, from: data)
                    let shortRecipes = recipesDTO.hits.map { ShortRecipe(dto: $0.recipe)
                    }
                    completion(.success(shortRecipes))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }

    func getSingleRecipe(
        recipeUri: String = URLComponentConstants.uri,
        completion: @escaping (Result<FullRecipe?, Error>) -> ()
    ) {
        components.scheme = URLComponentConstants.scheme
        components.host = URLComponentConstants.host
        components.path = URLComponentConstants.recipePath
        urlQueryItems.append(.init(name: URLComponentConstants.uriName, value: recipeUri))
        components.queryItems = urlQueryItems
        guard let url = components.url else { return }
        let urlRequest = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, _ in
            if let data = data {
                do {
                    let recipeDTO = try JSONDecoder().decode(
                        HitsDTO.self,
                        from: data
                    )
                    let recipe = recipeDTO.hits.first?.recipe
                    guard let recipe else { return }
                    let fullRecipe = FullRecipe(dto: recipe)
                    completion(.success(fullRecipe))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
