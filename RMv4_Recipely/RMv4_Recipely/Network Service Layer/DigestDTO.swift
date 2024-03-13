// DigestDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// DTO для пищевых веществ
struct DigestDTO: Codable {
    let label: LabelDTO
    let tag: String
    let total: Double
    let hasRDI: Bool
    let daily: Double
    let unit: UnitDTO
    let sub: [DigestDTO]?
}
