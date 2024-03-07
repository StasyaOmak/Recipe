// TermsOfUsePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс презентера модуля "Политики использования"
protocol TermsOfUsePresenterProtocol {
    /// функция-флаг нажатия на кнопку "закрыть экран"
    func closeButtonTapped()
}

/// Презентер "правил использования приложения"
final class TermsOfUsePresenter {
    // MARK: - Private Properties

    private weak var termsOfUseView: TermsOfUseViewControllerProtocol?
    private weak var coordinator: ProfileCoordinator?

    // MARK: - Initializers

    init(termsOfUseView: TermsOfUseViewControllerProtocol, coordinator: ProfileCoordinator) {
        self.termsOfUseView = termsOfUseView
        self.coordinator = coordinator
    }
}

// MARK: - TermsOfUsePresenter + TermsOfUsePresenterProtocol

extension TermsOfUsePresenter: TermsOfUsePresenterProtocol {
    func closeButtonTapped() {
        coordinator?.dismissBonusesScreen()
    }
}
