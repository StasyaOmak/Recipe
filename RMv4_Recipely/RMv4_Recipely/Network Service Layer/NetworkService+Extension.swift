// NetworkService+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

extension NetworkService {
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
    }

    func createAllRecipesUrlRequest(dishType: String, health: String?, query: String?) -> URLRequest? {
        var components = URLComponents()
        components.scheme = URLComponentConstants.scheme
        components.host = URLComponentConstants.host
        components.path = URLComponentConstants.allRecipesPath
        var urlQueryItems: [URLQueryItem] = [
            .init(name: URLComponentConstants.typeName, value: URLComponentConstants.type),
            .init(name: URLComponentConstants.idName, value: URLComponentConstants.id),
            .init(name: URLComponentConstants.keyName, value: URLComponentConstants.key),
        ]
        urlQueryItems.append(.init(name: URLComponentConstants.dishTypeName, value: dishType))

        if let health {
            urlQueryItems.append(.init(name: URLComponentConstants.healthName, value: health))
        }

        if let query {
            urlQueryItems.append(.init(name: URLComponentConstants.queryName, value: query))
        }

        components.queryItems = urlQueryItems
        guard let url = components.url else { return nil }
        return URLRequest(url: url)
    }

    func makeSingleRecipeUrlRequest(recipeUri: String) -> URLRequest? {
        var components = URLComponents()
        components.scheme = URLComponentConstants.scheme
        components.host = URLComponentConstants.host
        components.path = URLComponentConstants.recipePath
        var urlQueryItems: [URLQueryItem] = [
            .init(name: URLComponentConstants.typeName, value: URLComponentConstants.type),
            .init(name: URLComponentConstants.idName, value: URLComponentConstants.id),
            .init(name: URLComponentConstants.keyName, value: URLComponentConstants.key),
        ]
        urlQueryItems.append(.init(name: URLComponentConstants.uriName, value: recipeUri))
        components.queryItems = urlQueryItems
        guard let url = components.url else { return nil }
        return URLRequest(url: url)
    }
}
