// HitsDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура DTO верхнего уровня
struct HitsDTO: Codable {
    // Массив объектов HitDTO
    let hits: [HitDTO]
    // Ключ для массива hits в JSON
    enum CodingKeys: String, CodingKey {
        case hits
    }
}
