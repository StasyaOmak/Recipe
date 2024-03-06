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
}

/// Презентер модуля "Авторизация"
final class AuthPresenter {
    // MARK: - Constants

    enum Constants {
        static let emptyText = ""
        static let emailText = "@"
        static let dotText = "."
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
        if !login.contains(Constants.emailText), !login.contains(Constants.dotText) {
            view?.setLoginColor(color: Constants.redColor, isValidate: false, borderColor: Constants.redColor)
        } else {
            view?.setLoginColor(color: Constants.darkGrayColor, isValidate: true, borderColor: Constants.darkGrayColor)
            isLoginValid = true
        }
    }

    func checkPassword(password: String?) {
        guard let password = password else { return }
        if password == Constants.passwordText {
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

    func moveToMain() {
        if isLoginValid, isPasswordValid {
            authCoordinator?.onFinishFlow?()
        } else {
            view?.showEntryErrorMessage()
        }
    }
}
