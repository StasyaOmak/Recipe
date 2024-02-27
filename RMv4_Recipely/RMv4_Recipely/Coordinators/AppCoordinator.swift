// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главный координатор для приложения
final class AppCoordinator: BaseCoordinator {
    // MARK: - Private Properties

    // создаем экземпляр таббарa
    private var tabBarViewController: TabBarController?
    let builder = AppBuilder()

    /// переопределяем старт. отсюда у нас две точки входа в приложение, либо авторизация пройдена, либо нет
    /// пока нужно вручную откомментировать нужную для входа
    override func start() {
        toMain()
//        toAuth() // на красный экран авторизации
    }

    // MARK: - Private Methods

    private func toMain() {
        tabBarViewController = TabBarController()
        guard let tabBarViewController = tabBarViewController else { return }

        /// recipes
        let recipesModuleView = builder.makeRecipesModule()
        let recipesCoordinator = RecipesCoordinator(rootController: recipesModuleView)
        /// см. комм. к RecipesPresenter
        recipesModuleView.recipesPresenter?.coordinator = recipesCoordinator

        /// profile
        let profileModuleView = builder.makeProfileModule()
        let profileCoordinator = ProfileCoordinator(rootController: profileModuleView)
        /// аналогично - через протокол не получается, интерфейсы не допускают слабые ссылки
        profileModuleView.presenter?.coordinator = profileCoordinator

        tabBarViewController.setViewControllers(
            [recipesCoordinator.rootController, profileCoordinator.rootController],
            animated: false
        )
        setAsRoot​(​_​: tabBarViewController)
    }

    private func toAuth() {
        let authCoordinator = AuthCoordinator()
        /// Что произойдет после завершения авторизации:
        authCoordinator.onFinishFlow = { [weak self] in
            /// удаляем авторизацию из массива координаторов
            self?.remove(coordinator: authCoordinator)
            /// переходим в главный экран
            self?.toMain()
        }
        /// Добавили координатор в массив дочек
        add(coordinator: authCoordinator)
        /// запустили координатор
        authCoordinator.start()
    }
}
