// FavoritesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс вью модуля "избранные рецепты"
protocol FavoritesViewControllerProtocol: AnyObject {
    /// свойство типа интерфейса вью
    var favoritesPresenter: FavoritesPresenterProtocol? { get set }
}

/// Экран отображения избранных рецептов
final class FavoritesViewController: UIViewController {
    private enum Constants {}

    // MARK: - Public Properties

    var favoritesPresenter: FavoritesPresenterProtocol?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow.withAlphaComponent(0.1)
    }
}

// MARK: - FavoritesViewController + FavoritesViewControllerProtocol

extension FavoritesViewController: FavoritesViewControllerProtocol {}
