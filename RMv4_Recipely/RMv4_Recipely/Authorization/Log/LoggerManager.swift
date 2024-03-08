// LoggerManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

///  Реализация логгера в приложении
protocol LoggerManagerProtocol {
    /// Функция для вызова добавления в Логгер
    func log(_ action: LogAction)
}

/// Логгер Менеджер
final class LoggerManager: LoggerManagerProtocol {
    func log(_ action: LogAction) {
        let command = LogCommand(action: action)
        LoggerInvoker.shared.addLogCommand(command)
    }
}
