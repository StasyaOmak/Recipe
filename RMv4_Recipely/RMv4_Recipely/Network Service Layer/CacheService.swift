// CacheService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс загрузки изображений
protocol LoadImageServiceProtocol {
    func loadImage(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
}

/// Сервис загрузки изображений
final class LoadImageService: LoadImageServiceProtocol {
    func loadImage(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession(configuration: config)
        session.dataTask(with: url, completionHandler: completion).resume()
    }
}
