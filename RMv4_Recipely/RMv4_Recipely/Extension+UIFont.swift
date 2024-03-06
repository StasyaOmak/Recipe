// Extension+UIFont.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для работы с общими шрифтами
extension UIFont {
    static var fontStoreMap: [String: UIFont] = [:]

    static func createFont(name: String, size: CGFloat) -> UIFont? {
        let key = "\(name)\(size)"
        if let font = fontStoreMap[key] {
            return font
        }
        let font = UIFont(name: name, size: size)
        fontStoreMap[key] = font
        return font
    }
}
