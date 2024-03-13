// TotalDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// DTO для суммарных значений
struct TotalDTO: Codable {
    /// Название лейбла
    let label: LabelDTO
    /// Числовой параметр лейбла
    let quantity: Double
    /// Единицы измерения и другие суффиксы
    let unit: UnitDTO
}
