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
}

/// Перечисление с содержанием таблицы профиля пользователя
enum ProfileTableViewCell {
    /// ячейка-заголовок с аватаром и именем пользователя
    case headerCell
    /// стандартные ячейки с опциями
    case cells

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
struct OptionCell {
    /// тип ячейки
    let type: ProfileTableViewCell.CellType
    /// заголовок ячейки
    let title: String
    /// картинка с иконкой ячейки
    let imageName: String
}
