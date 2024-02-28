// BonusesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс презентера модуля "Бонусы"
protocol BonusesPresenterProtocol {
    /// свойство типа вью
    var bonusesView: BonusesViewControllerProtocol? { get set }
    /// свойство-координатор
    var coordinator: ProfileCoordinator? { get set }
    /// свойство, хранящее данные пользователя
    var user: User? { get }

    /// функция-флаг нажатия на кнопку "закрыть экран"
    func closeButtonTapped()
}

final class BonusesPresenter {
    weak var bonusesView: BonusesViewControllerProtocol?
    weak var coordinator: ProfileCoordinator?

    var user: User?
}

/// Расширение презентера методами протокола
extension BonusesPresenter: BonusesPresenterProtocol {
    /// имплементация метода протокола
    func closeButtonTapped() {
        print(coordinator == nil)
        coordinator?.dismissBonusesScreen()
    }
}
