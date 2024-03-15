// Proxy.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Прокси интерфейса загрузки изображений
final class Proxy: LoadImageServiceProtocol {
    private var service: LoadImageServiceProtocol

    init(service: LoadImageServiceProtocol) {
        self.service = service
    }

    func loadImage(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let manager = FileManager.default
        guard let documentsDirectory = manager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let imageUrl = documentsDirectory.appendingPathComponent(url.lastPathComponent)
        if manager.fileExists(atPath: imageUrl.path) {
            do {
                let data = try Data(contentsOf: imageUrl)
                completion(data, nil, nil)
            } catch {
                completion(nil, nil, error)
            }
        } else {
            service.loadImage(url: url) { data, responce, error in
                do {
                    try data?.write(to: imageUrl)
                    completion(data, responce, error)
                } catch {
                    completion(nil, responce, error)
                }
            }
        }
    }
}
