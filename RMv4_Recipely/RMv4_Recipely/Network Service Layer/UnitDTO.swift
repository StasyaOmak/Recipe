// UnitDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Перечисление для единиц измерения
enum UnitDTO: String, Codable {
    case empty = "%"
    // swiftlint:disable identifier_name
    /// граммы
    case g
    // swiftlint:enable identifier_name
    /// килокалории
    case kcal
    /// миллиграммы
    case mg
    /// микрограммы
    case µg
}
