// Command.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Команда логирования действий
final class LogCommand {
    // MARK: - Private Properties

    private let action: LogAction

    // MARK: - Public Properties

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

    // MARK: - Initializers

    init(action: LogAction) {
        self.action = action
    }
}
