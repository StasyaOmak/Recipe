// BonusesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol BonusesPresenterProtocol {
    var bonusesView: BonusesViewControllerProtocol? { get }
    var user: User? { get }

    func closeButtonTapped()
}

final class BonusesPresenter {
    weak var bonusesView: BonusesViewControllerProtocol?
    weak var coordinator: ProfileCoordinator?
    var user: User?
}

extension BonusesPresenter: BonusesPresenterProtocol {
    func closeButtonTapped() {
        bonusesView?.dismissScreen()
    }
}
