// State.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Состояния экранов
enum State<Model> {
    /// Идет загрузка
    case loading
    /// Загрузка успешно завершена
    case data(Model)
    /// Нет данных
    case noData
    /// Ошибка
    case error(_ error: Error)
}
