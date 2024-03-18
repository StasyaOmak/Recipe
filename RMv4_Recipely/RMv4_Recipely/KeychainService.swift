// KeychainService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import Keychain

/// Сервис хранения данных авторизации
final class KeychainService {
    static let shared = KeychainService()
    private static let passwordKey = "Password"
    private static let loginKey = "Login"

    private init() {}

    func loadPassword() -> String? {
        Keychain.load(KeychainService.passwordKey)
    }

    func checkPassword(password: String) -> Bool? {
        let savedPassword = Keychain.load(KeychainService.passwordKey)
        guard let savedPassword else { return nil }
        return savedPassword == password
    }

    func savePassword(password: String) {
        Keychain.save(password, forKey: KeychainService.passwordKey)
    }

    func saveLogin(login: String) {
        Keychain.save(login, forKey: KeychainService.loginKey)
    }

    func checkLogin(login: String) -> Bool? {
        let savedLogin = Keychain.load(KeychainService.loginKey)
        guard let savedLogin else { return nil }
        return savedLogin == login
    }

    func loadLogin() -> String? {
        Keychain.load(KeychainService.loginKey)
    }

    func cleanLoginInfo() {
        Keychain.delete(KeychainService.passwordKey)
        Keychain.delete(KeychainService.loginKey)
    }
}
