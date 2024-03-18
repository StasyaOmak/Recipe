// AuthPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import Keychain

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
        var isLoginSaved = KeychainService.shared.checkLogin(login: login)
        if isLoginSaved == nil {
            view?.setLoginColor(color: Constants.darkGrayColor, isValidate: true, borderColor: Constants.darkGrayColor)
            KeychainService.shared.saveLogin(login: login)
            isLoginValid = true
        } else if isLoginSaved == true {
            view?.setLoginColor(color: Constants.darkGrayColor, isValidate: true, borderColor: Constants.darkGrayColor)
            isLoginValid = true
        } else {
            view?.setLoginColor(color: Constants.redColor, isValidate: false, borderColor: Constants.redColor)
        }
    }

    func checkPassword(password: String?) {
        guard let password = password else { return }
        var isPasswordSaved = KeychainService.shared.checkPassword(password: password)
        if isPasswordSaved == nil {
            view?.setPasswordColor(
                color: Constants.darkGrayColor,
                isValidate: true,
                borderColor: Constants.darkGrayColor
            )
            KeychainService.shared.savePassword(password: password)
            isPasswordValid = true
        } else if isPasswordSaved == true {
            view?.setPasswordColor(
                color: Constants.darkGrayColor,
                isValidate: true,
                borderColor: Constants.darkGrayColor
            )
            isPasswordValid = true
        } else {
            view?.setPasswordColor(color: Constants.redColor, isValidate: false, borderColor: Constants.redColor)
        }
    }

    func logOut() {
        KeychainService.shared.cleanLoginInfo()
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
