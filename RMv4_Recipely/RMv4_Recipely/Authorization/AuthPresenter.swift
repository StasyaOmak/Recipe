// AuthPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol AuthPresenterProtocol {
    /// здесь будет абстрактный интерфейс презентера этого модуля
}

/// Презентер модуля входа в приложение
final class AuthPresenter {
    /// здесь будет логика этого модуля

    /// связывает с вьюхой
    weak var view: AuthViewControllerProtocol?
    /// связывает с координатором этого модуля
    weak var authCoordinator: AuthCoordinator?
}

extension AuthPresenter: AuthPresenterProtocol {
    /// здесь будет имплементация интерфейса презентеру этого модуля
}
