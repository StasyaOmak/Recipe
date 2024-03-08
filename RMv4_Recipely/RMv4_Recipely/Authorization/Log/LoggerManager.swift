// LoggerManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol LoggerManagerProtocol {
    /// Функция для вызова добавления в Логгер
    func log(_ action: LogActions)
}

/// Логгер Менеджер
class LoggerManager: LoggerManagerProtocol {
    func log(_ action: LogActions) {
        let command = LogCommand(action: action)
        LoggerInvoker.shared.addLogCommand(command)
    }
}
