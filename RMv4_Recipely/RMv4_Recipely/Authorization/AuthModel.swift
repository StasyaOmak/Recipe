// AuthModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель экрана входа
struct AuthInformation {
    /// логин
    var login: String
    /// пароль
    var password: String
    /// Статус показа клавиатуры
    var keyboardIsShown = false
    /// Высота клавиатуры
    var keyboardHeight: CGFloat = 0.0
}
