// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var appCoordinator: AppCoordinator?
    private var loggerManager = LoggerManager()
    private var networkService = NetworkService()

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        if let window {
            window.makeKeyAndVisible()
            appCoordinator = AppCoordinator(
                builder: AppBuilder(
                    loggerManager: loggerManager,
                    networkService: networkService
                )
            )
            networkService.getRecipes(health: nil, query: nil) { _ in
            }
            networkService.getSingleRecipe { _ in
            }
            appCoordinator?.start()
        }
    }
}
