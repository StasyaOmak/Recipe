// ProfileModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель модуля профиль пользователя
struct User {
    /// имя пользователя
    var name: String
    /// аватар пользователя
    var avatarImageName: String
    /// Число бонусов
    var bonusesCount: Int?
    /// Экземпляр "Пользователь"
    static var user = User(name: "Maria", avatarImageName: "user", bonusesCount: 100)
    /// Метод получения мока
    static func mockData() -> User {
        user
    }
}

/// Перечисление с содержанием таблицы профиля пользователя
enum ProfileFieldType {
    /// ячейка-заголовок с аватаром и именем пользователя
    case header
    /// стандартные ячейки с опциями
    case common

    /// Перечисление с типами ячеек-опций
    enum CellType {
        /// бонусы
        case bonuses
        /// условия использования
        case terms
        /// выйти из приложения
        case logOut
    }
}

/// Содержание ячеек с записями в таблице профиля пользователя
struct Profile {
    /// тип ячейки
    let type: ProfileFieldType.CellType
    /// заголовок ячейки
    let title: String
    /// картинка с иконкой ячейки
    let imageName: String

    static func mockData() -> [Profile] {
        let profileCells = [
            Profile(type: .bonuses, title: "Bonuses", imageName: "star.fill"),
            Profile(type: .terms, title: "Terms & Privacy Policy", imageName: "doc.fill"),
            Profile(
                type: .logOut,
                title: "Log Out",
                imageName: "rectangle.portrait.and.arrow.right.fill"
            )
        ]
        return profileCells
    }
}
