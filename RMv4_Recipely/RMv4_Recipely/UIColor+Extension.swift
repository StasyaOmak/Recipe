// UIColor+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для работы с общими цветами
extension UIColor {
    static var colorStoreMap: [String: UIColor] = [:]

    static func createColor(
        _ red: CGFloat,
        _ green: CGFloat,
        _ blue: CGFloat,
        _ alpha: CGFloat
    ) -> UIColor {
        let key = "\(red)\(green)\(blue)\(alpha)"
        if let color = colorStoreMap[key] {
            return color
        }
        let color = UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
        colorStoreMap[key] = color
        return color
    }
}
