// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс презентера модуля "Профиль"
protocol ProfilePresenterProtocol: AnyObject {
    /// свойство типа вью этого модуля
    var view: ProfileViewControllerProtocol? { get set }
    /// свойство-координатор
    var coordinator: ProfileCoordinator? { get set }
    /// свойство с данными пользователя
    var user: User { get set }

    /// метод смены имени
    func changeUserName(name: String)
    /// метод-флаг нажатия на кнопку "редактировать"
    func editButtonTapped()
    /// метод-флаг нажатия на ячейку "бонусы"
    func bonusesCellTapped()
}

/// Презентер модуля "Профиль пользователя"
final class ProfilePresenter {
    // MARK: - Public Properties

    weak var view: ProfileViewControllerProtocol?
    weak var coordinator: ProfileCoordinator?

    // MARK: - Mocks

    var user: User = .init(name: "Name", avatarImageName: "user", bonusesCount: 100)
}

/// Расширение презентера методами протокола
extension ProfilePresenter: ProfilePresenterProtocol {
    func editButtonTapped() {
        view?.showNameEditorAlert()
    }

    func bonusesCellTapped() {
        coordinator?.moveToBonusesScreen()
    }

    func changeUserName(name: String) {
        user.name = name
        view?.reloadTableView()
    }
}
