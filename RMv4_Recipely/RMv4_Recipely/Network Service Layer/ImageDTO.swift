// ImageDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// DTO для изображений
struct ImageDTO: Codable {
    /// Типы изображений - заглушка, маленькое, обычное
    let thumbnail, small, regular: ImageParameterDTO
    /// Большое изображение
    let large: ImageParameterDTO?

    /// Ключи для парсинга в DTO
    enum CodingKeys: String, CodingKey {
        case thumbnail = "THUMBNAIL"
        case small = "SMALL"
        case regular = "REGULAR"
        case large = "LARGE"
    }
}

/// DTO для больших изображений
struct ImageParameterDTO: Codable {
    /// Ссылка на изображение
    let url: String
    /// Сараметры ширины и высоты
    let width, height: Int
}
