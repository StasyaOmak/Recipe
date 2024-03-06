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
}

/// Презентер модуля "Профиль пользователя"
final class ProfilePresenter {
    // MARK: - Public Properties

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
//        coordinator?.moveToTermsOfUseScreen()
        view?.showScreanTerms()
        print(1)
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
        view?.reloadTableView()
    }

    func getUserInfo() -> User {
        let user = User.sendMock()
        return user
    }
}
