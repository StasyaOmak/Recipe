// RecipesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol RecipesViewControllerProtocol: AnyObject {}

/// Экран с категориями рецептов
final class RecipesViewController: UIViewController {
    // MARK: - Public Properties

    var recipesPresenter: RecipesPresenterProtocol?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.recipesPresenter?.coordinator?.moveToRecipeListScreen(category: .fish)
        }
    }
}

extension RecipesViewController: RecipesViewControllerProtocol {}
