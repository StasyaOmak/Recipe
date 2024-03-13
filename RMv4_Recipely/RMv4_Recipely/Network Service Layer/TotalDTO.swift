// TotalDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// DTO для суммарных значений
struct TotalDTO: Codable {
    /// название лейбла
    let label: LabelDTO
    /// числовой параметр лейбла
    let quantity: Double
    /// единицы измерения и другие суффиксы
    let unit: UnitDTO
}
