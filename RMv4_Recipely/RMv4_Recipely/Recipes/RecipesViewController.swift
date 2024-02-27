// RecipesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol RecipesViewControllerProtocol: AnyObject {}

/// Экран с рецептами
final class RecipesViewController: UIViewController {
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

    var recipesPresenter: RecipesPresenter?

    // MARK: - Private Properties

    // MARK: - Initializers

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    // MARK: - Public Methods

    // MARK: - IBAction

    // MARK: - Private Methods
}

extension RecipesViewController: RecipesViewControllerProtocol {}
