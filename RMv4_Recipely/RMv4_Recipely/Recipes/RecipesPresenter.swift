// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol RecipesPresenterProtocol {}

final class RecipesPresenter {
    weak var view: RecipesViewControllerProtocol?
    weak var coordinator: RecipesCoordinator?
}

// extension RecipesPresenter: RecipesPresenterProtocol {
//
// }
