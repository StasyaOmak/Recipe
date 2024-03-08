// Invoker.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Инвокер
final class LoggerInvoker {
    // MARK: Singleton

    static let shared = LoggerInvoker()

    // MARK: Private properties

    private let logger = Logger()
    private var commands: [LogCommand] = []

    // MARK: Internal

    func addLogCommand(_ command: LogCommand) {
        commands.append(command)
        executeCommandsIfNeeded()
    }

    // MARK: Private methods

    private func executeCommandsIfNeeded() {
        commands.forEach { self.logger.writeMessageToLog($0.logMessage) }
        commands = []
    }
}
