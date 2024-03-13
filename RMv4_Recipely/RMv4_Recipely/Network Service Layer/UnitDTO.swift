// UnitDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Перечисление для единиц измерения
enum UnitDTO: String, Codable {
    case empty = "%"
    // swiftlint:disable identifier_name
    /// Граммы
    case g
    // swiftlint:enable identifier_name
    /// Килокалории
    case kcal
    /// Миллиграммы
    case mg
    /// Микрограммы
    case µg
}
