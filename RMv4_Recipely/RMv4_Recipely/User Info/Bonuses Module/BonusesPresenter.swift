// BonusesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс презентера модуля "Бонусы"
protocol BonusesPresenterProtocol {
    /// функция-флаг нажатия на кнопку "закрыть экран"
    func closeButtonTapped()
    /// функция установки данных пользователя в модуль
    func setUserInfo(user: User)
}

final class BonusesPresenter {
    // MARK: - Private Properties

    private weak var bonusesView: BonusesViewControllerProtocol?
    private weak var coordinator: ProfileCoordinator?

    // MARK: - Initializers

    init(bonusesView: BonusesViewControllerProtocol, coordinator: ProfileCoordinator) {
        self.bonusesView = bonusesView
        self.coordinator = coordinator
    }
}

// MARK: - Extension BonusesPresenter + BonusesPresenterProtocol

extension BonusesPresenter: BonusesPresenterProtocol {
    /// имплементация метода протокола
    func closeButtonTapped() {
        coordinator?.dismissBonusesScreen()
    }

    func setUserInfo(user: User) {
        bonusesView?.showUserInfo(user: user)
    }
}
