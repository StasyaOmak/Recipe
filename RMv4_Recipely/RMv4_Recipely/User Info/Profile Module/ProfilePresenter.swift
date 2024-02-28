// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol ProfilePresenterProtocol: AnyObject {
    var view: ProfileViewControllerProtocol? { get set }
    var coordinator: ProfileCoordinator? { get set }
    var user: User { get set }

    func changeUserName(name: String)
    func editButtonTapped()
    func bonusesCellTapped()
}

/// Презентер модуля "Профиль пользователя"
final class ProfilePresenter {
    // MARK: - Public Properties

    weak var view: ProfileViewControllerProtocol?
    weak var coordinator: ProfileCoordinator?

    // MARK: - Mocks

    var user: User = .init(name: "Name", avatarImageName: "user", bonusesCount: 100)

    // MARK: - Private Properties

    // MARK: - Initializers

    // MARK: - Life Cycle

    // MARK: - Public Methods

    // MARK: - IBAction

    // MARK: - Private Methods
}

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
