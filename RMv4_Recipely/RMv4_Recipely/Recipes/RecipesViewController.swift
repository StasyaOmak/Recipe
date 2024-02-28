// RecipesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol RecipesViewControllerProtocol: AnyObject {}

/// Экран с рецептами
final class RecipesViewController: UIViewController {

    // MARK: - Public Properties

    var recipesPresenter: RecipesPresenterProtocol?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

extension RecipesViewController: RecipesViewControllerProtocol {}
