// UIColor+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для работы с общими цветами
extension UIColor {
    /// словарь для хранения уже записанных цветов
    static var colorStoreMap: [String: UIColor] = [:]

    /// метод для создания и переиспользования уже записанных цветов через модель RGB. Если цвет ранее не создавался,
    /// создаст и сохранит в colorStoreMap, если создавался, вернет нужный из colorStoreMap.
    /// - Parameters:
    ///     - red: Значение красного канала
    ///     - green: Значение зеленого канала
    ///     - blue:  Значение синего канала
    ///     - alpha:  Значение прозрачности
    /// - returns: цвет UIcolor
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
