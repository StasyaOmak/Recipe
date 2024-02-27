// FavoritesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран отображения избранных рецептов
final class FavoritesViewController: UIViewController {
    // MARK: - Types

    // MARK: - Constants

    private enum Constants {
        //    static let
        //    static let
        //    static let
        //    static let
    }

    // MARK: - IBOutlets

    // MARK: - Visual Components

    // MARK: - Public Properties

    var favoritesPresenter: FavoritesPresenterProtocol?

    // MARK: - Private Properties

    // MARK: - Initializers

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow.withAlphaComponent(0.1)
    }

    // MARK: - Public Methods

    // MARK: - IBAction

    // MARK: - Private Methods
}
