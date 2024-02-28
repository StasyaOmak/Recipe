// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol ProfilePresenterProtocol: AnyObject {
    /// абстрактный интерфейс
    var view: ProfileViewControllerProtocol? { get set }
    var coordinator: ProfileCoordinator? { get set }
    var user: User { get set }

    func changeUserName(name: String)
    func editButtonTapped()
}

/// Презентер модуля "Профиль пользователя"
final class ProfilePresenter {
    // MARK: - Constants

    private enum Constants {
        //    static let
        //    static let
        //    static let
        //    static let
    }

    // MARK: - Public Properties

    weak var view: ProfileViewControllerProtocol?
    weak var coordinator: ProfileCoordinator?

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

    /// здесь будет имплементация интерфейса в этот класс
    func changeUserName(name: String) {
        user.name = name
        view?.reloadTableView()
    }
}
