// ProfileModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель модуля профиль пользователя
struct User {
    var name: String
    var avatarImageName: String
    var bonusesCount: Int?
}

/// Перечисление с содержанием таблицы профиля пользователя
enum ProfileTableViewCell {
    case headerCell
    case cells

    enum CellType {
        case bonuses
        case terms
        case logOut
    }
}

/// Содержание ячеек с записями в таблице профиля пользователя
struct OptionCell {
    let type: ProfileTableViewCell.CellType
    let title: String
    let imageName: String
}
