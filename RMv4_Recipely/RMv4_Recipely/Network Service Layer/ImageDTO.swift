// ImageDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// DTO для изображений
struct ImagesDTO: Codable {
    /// типы изображений - заглушка, маленькое, обычное
    let thumbnail, small, regular: LargeDTO
    /// большое изображение
    let large: LargeDTO?

    /// ключи для парсинга в DTO
    enum CodingKeys: String, CodingKey {
        case thumbnail = "THUMBNAIL"
        case small = "SMALL"
        case regular = "REGULAR"
        case large = "LARGE"
    }
}

/// DTO для больших изображений
struct LargeDTO: Codable {
    /// ссылка на изображение
    let url: String
    /// параметры ширины и высоты
    let width, height: Int
}
