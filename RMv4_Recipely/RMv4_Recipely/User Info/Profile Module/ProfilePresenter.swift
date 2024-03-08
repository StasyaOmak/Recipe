// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс презентера модуля "Профиль"
protocol ProfilePresenterProtocol: AnyObject {
    /// метод смены имени
    func changeUserName(name: String)
    /// метод-флаг нажатия на кнопку "редактировать"
    func editButtonTapped()
    /// метод-флаг нажатия на ячейку "TermsOfUse"
    func termsOfUseCellTapped()
    /// метод-флаг нажатия на ячейку "бонусы"
    func bonusesCellTapped()
    /// метод для получения данных пользователя
    func getUserInfo() -> User
    /// метод вызода в экран авторизации
    func logOut()
}

/// Презентер модуля "Профиль пользователя"
final class ProfilePresenter {
    // MARK: - Private Properties

    private weak var view: ProfileViewControllerProtocol?
    private weak var coordinator: ProfileCoordinator?

    // MARK: - Initializers

    init(view: ProfileViewControllerProtocol, coordinator: ProfileCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}

// - MARK: Extension ProfilePresenter + ProfilePresenterProtocol
extension ProfilePresenter: ProfilePresenterProtocol {
    func termsOfUseCellTapped() {
        view?.showTermsScreen()
    }

    func editButtonTapped() {
        view?.showNameEditorAlert()
    }

    func bonusesCellTapped() {
        let user = User.sendMock()
        coordinator?.moveToBonusesScreen(user: user)
    }

    func changeUserName(name: String) {
        User.user.name = name
        UserSettings.shared.changeUserName(to: name)
        view?.reloadTableView()
    }

    func getUserInfo() -> User {
        let user = User.sendMock()
        return user
    }

    func logOut() {
        UserSettings.shared.logOut()
        coordinator?.onFinishFlow?()
    }
}
