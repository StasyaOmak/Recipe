// ProfileCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class ProfileCoordinator: BaseCoordinator {
    private var appBuilder = AppBuilder()
    var rootController: UINavigationController
    
    var onFinishFlow: (() -> ())?

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }
    
    func logOut() {
        onFinishFlow?()
    }

    func moveToBonusesScreen() {
        let bonusesModule = appBuilder.makeBonusesModule()
        rootController.present(bonusesModule, animated: true)
    }
    
    func dismissBonusesScreen() {
        rootController.dismiss(animated: true)
    }
}
