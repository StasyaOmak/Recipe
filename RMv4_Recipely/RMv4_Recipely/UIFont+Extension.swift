// UIFont+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для работы с общими шрифтами
extension UIFont {
    /// словарь для хранения уже записанных шрифтов
    static var fontStoreMap: [String: UIFont] = [:]
    /// метод для создания и сохранения определенного шрифта определенного размера. Ели шрифт ранее не создавался,
    /// сохранит его в fontStoreMap, если создавался  - вернет из fontStoreMap.
    /// - Parameters:
    ///     - name: Название шрифта
    ///     - size: Размер шрифта
    /// - Returns: шрифт UIFont
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
