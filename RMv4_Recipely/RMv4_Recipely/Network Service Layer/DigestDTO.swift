// DigestDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// DTO для пищевых веществ
struct DigestDTO: Codable {
    /// Название пищевого вещества
    let label: LabelDTO
    /// Тег пищевого вещества
    let tag: String
    /// Общее количество пищевого вещества
    let total: Double
    /// Наличие рекомендуемого ежедневного потребления
    let hasRDI: Bool
    /// Ежедневное потребление пищевого вещества
    let daily: Double
    /// Единица измерения пищевого вещества
    let unit: UnitDTO
    /// Подчиненные пищевые вещества
    let sub: [DigestDTO]?
}
