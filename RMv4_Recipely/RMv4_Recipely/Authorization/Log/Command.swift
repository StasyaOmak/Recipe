// Command.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Команда логирования действий
final class LogCommand {
    private let action: LogActions

    /// Инициализатор с действием
    /// - Parameter action: Действие для логирования
    init(action: LogActions) {
        self.action = action
    }
    
    /// Сообщение для логирования, соответствующее действию
    var logMessage: String {
        switch action {
        case .openRecipe:
            "Пользователь открыл “Экран рецептов”"
        case .openCatagoryOfRecipe:
            "Пользователь перешел на ”Экран со списком рецептов из Рыбы”"
        case .openDetailsRecipe:
            "Пользователь открыл ”Детали рецепта”"
        case .tapShareButton:
            "Пользователь поделился рецептом"
        }
    }
}
