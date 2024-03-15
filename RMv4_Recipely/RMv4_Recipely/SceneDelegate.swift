// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Public Properties

    var window: UIWindow?

    // MARK: - Private Properties

    private var appCoordinator: AppCoordinator?
    private var loggerManager = LoggerManager()
    private var networkService = NetworkService()
    private var imageLoader = LoadImageService()
    private lazy var imageLoaderProxy = Proxy(service: imageLoader)

    // MARK: - Public Methods

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        setWindow()
    }

    private func setWindow() {
        if let window {
            window.makeKeyAndVisible()
            appCoordinator = AppCoordinator(
                builder: AppBuilder(
                    loggerManager: loggerManager,
                    networkService: networkService, imageLoader: imageLoaderProxy
                )
            )
            appCoordinator?.start()
        }
    }
}
