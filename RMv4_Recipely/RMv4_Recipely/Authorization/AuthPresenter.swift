// AuthPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана авторизации
protocol AuthPresenterProtocol {
    func checkLogin(login: String?)
    func checkPassword(password: String?)
}

protocol AuthViewProtocol: AnyObject {
    func setLoginColor(color: String, isValidate: Bool, borderColor: String)
    func setPasswordColor(color: String, isValidate: Bool, borderColor: String)
}

/// Презентер модуля входа в приложение
final class AuthPresenter {
    enum Constants {
        static let emptyText = ""
        static let emailText = "@"
        static let passwordText = "Qwerty12345"
        static let redColor = "error"
        static let darkGrayColor = "dark"
    }

    /// связывает с вьюхой
    weak var view: AuthViewProtocol?
    /// связывает с координатором этого модуля
    weak var authCoordinator: AuthCoordinator?

    private var authModel = AuthInformation(login: Constants.emptyText, password: Constants.emptyText)
}

extension AuthPresenter: AuthPresenterProtocol {
    func checkLogin(login: String?) {
        guard let login = login else { return }
        if !login.hasSuffix(Constants.emailText) {
            view?.setLoginColor(color: Constants.redColor, isValidate: false, borderColor: Constants.redColor)
        } else {
            view?.setLoginColor(color: Constants.darkGrayColor, isValidate: true, borderColor: Constants.darkGrayColor)
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
        } else {
            view?.setPasswordColor(color: Constants.redColor, isValidate: false, borderColor: Constants.redColor)
        }
    }
}
