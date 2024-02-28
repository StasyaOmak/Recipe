// AuthPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol AuthPresenterProtocol {
    func checkLogin(login: String?)
    func checkPassword(password: String?)
}

protocol AuthViewControllerProtocol: AnyObject {
    func setLoginColor(color: UIColor, isValidate: Bool, borderColor: UIColor)
    func setPasswordColor(color: UIColor, isValidate: Bool, borderColor: UIColor)
}

/// Презентер модуля входа в приложение
final class AuthPresenter {
    enum Constants {
        static let emptyText = ""
    }

    /// связывает с вьюхой
    weak var view: AuthViewControllerProtocol?
    /// связывает с координатором этого модуля
    weak var authCoordinator: AuthCoordinator?

    private var authModel = AuthInformation(login: Constants.emptyText, password: Constants.emptyText)
}

extension AuthPresenter: AuthPresenterProtocol {
    func checkLogin(login: String?) {
        guard let login = login else { return }
        if !login.hasSuffix("@") {
            view?.setLoginColor(color: .red, isValidate: false, borderColor: .red)
        } else {
            view?.setLoginColor(color: .darkGray, isValidate: true, borderColor: .darkGray)
        }
    }

    func checkPassword(password: String?) {
        guard let password = password else { return }
        if password == "Qwerty12345" {
            view?.setPasswordColor(color: .darkGray, isValidate: true, borderColor: .darkGray)
        } else {
            view?.setPasswordColor(color: .red, isValidate: false, borderColor: .red)
        }
    }
}
