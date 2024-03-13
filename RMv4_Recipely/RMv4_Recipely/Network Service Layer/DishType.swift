// DishType.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// TODO: уже было одно перечисление, можно ли использовать его?
/// Перечисление для типов блюд, используется в качестве url-компонента
enum DishType: String, Codable {
    /// Салат
    case salad
    /// Первое блюдо
    case soup
    /// Второе блюдо?
    case mainCourse = "Main course"
    /// Панкейки
    case pancake
    /// Напитки
    case drinks
    /// Десерты
    case desserts
}
