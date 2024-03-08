// AuthPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана авторизации
protocol AuthPresenterProtocol {
    /// метод проверки логина
    func checkLogin(login: String?)
    /// метод проверки пароля
    func checkPassword(password: String?)
    /// метод перехода в основной флоу
    func moveToMain()
    /// метод выхода из профиля
    func logOut()
}

/// Презентер модуля "Авторизация"
final class AuthPresenter {
    // MARK: - Constants

    enum Constants {
        static let emptyText = ""
        static let emailText = "@"
        static let passwordText = "Qwerty12345"
        static let redColor = "error"
        static let darkGrayColor = "dark"
    }

    // MARK: - Private Properties

    private weak var view: AuthViewProtocol?
    private weak var authCoordinator: AuthCoordinator?

    private var authModel = AuthInformation(login: Constants.emptyText, password: Constants.emptyText)
    private var isLoginValid = false
    private var isPasswordValid = false

    // MARK: - Initializers

    init(view: AuthViewProtocol, authCoordinator: AuthCoordinator) {
        self.view = view
        self.authCoordinator = authCoordinator
    }
}

// MARK: - AuthPresenter + AuthPresenterProtocol

extension AuthPresenter: AuthPresenterProtocol {
    func checkLogin(login: String?) {
        guard let login = login else { return }
        var user = UserSettings.shared.getUserSettings()
        if user.login == nil {
            view?.setLoginColor(color: Constants.darkGrayColor, isValidate: true, borderColor: Constants.darkGrayColor)
            user.login = login
            UserSettings.shared.save(user)
            isLoginValid = true
        } else if let savedLogin = user.login, login == savedLogin {
            view?.setLoginColor(color: Constants.darkGrayColor, isValidate: true, borderColor: Constants.darkGrayColor)
            isLoginValid = true
        } else {
            view?.setLoginColor(color: Constants.redColor, isValidate: false, borderColor: Constants.redColor)
        }
    }

    func checkPassword(password: String?) {
        guard let password = password else { return }
        var user = UserSettings.shared.getUserSettings()
        if user.password == nil {
            view?.setPasswordColor(
                color: Constants.darkGrayColor,
                isValidate: true,
                borderColor: Constants.darkGrayColor
            )
            user.password = password
            UserSettings.shared.save(user)
            isPasswordValid = true
        } else if let savedPassword = user.password, password == savedPassword {
            view?.setPasswordColor(
                color: Constants.darkGrayColor,
                isValidate: true,
                borderColor: Constants.darkGrayColor
            )
            UserSettings.shared.save(user)
            isPasswordValid = true
        } else {
            view?.setPasswordColor(color: Constants.redColor, isValidate: false, borderColor: Constants.redColor)
        }
    }

    func logOut() {
        UserSettings.shared.logOut()
    }

    func moveToMain() {
        if isLoginValid, isPasswordValid {
            authCoordinator?.onFinishFlow?()
        } else {
            view?.showEntryErrorMessage()
            view?.hideErrorMessageLabel()
        }
    }
}
