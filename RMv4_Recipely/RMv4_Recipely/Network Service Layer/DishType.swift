// DishType.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// TODO: уже было одно перечисление, можно ли использовать его?
/// Перечисление для типов блюд, используется в качестве url-компонента
enum DishType: String, Codable {
    /// салат
    case salad
    /// первое блюдо
    case soup
    /// второе блюдо?
    case mainCourse = "Main course"
    /// панкейки
    case pancake
    /// напитки
    case drinks
    /// десерты
    case desserts
}
