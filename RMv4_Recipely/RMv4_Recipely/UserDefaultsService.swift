// UserDefaultsService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// User Defaults Service
/// вероятно, это и есть Caretaker
final class UserSettings {
    static let shared = UserSettings()
    static let userDefaults = UserDefaults.standard
    private let key = "User"

    func getUserSettings() -> User {
        guard let data = UserSettings.userDefaults.data(forKey: key) else { return User() }
        do {
            let user = try JSONDecoder().decode(User.self, from: data)
            return user
        } catch {
            print(error.localizedDescription)
            return User()
        }
    }

    func save(_ user: User) {
        do {
            let data = try JSONEncoder().encode(user)
            UserSettings.userDefaults.set(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }

    func logOut() {
        var user = getUserSettings()
        user = User()
        save(user)
    }

    func changeUserName(to value: String) {
        var user = getUserSettings()
        user.name = value
        save(user)
    }

    func changeUserImage(imageData: Data) {
        var user = getUserSettings()
        user.avatarImageData = imageData
        UserSettings.shared.save(user)
    }
}
