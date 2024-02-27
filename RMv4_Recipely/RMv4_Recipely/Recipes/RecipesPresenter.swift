// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol RecipesPresenterProtocol {
    var coordinator: RecipesCoordinator? { get set }
}

final class RecipesPresenter {
    weak var view: RecipesViewControllerProtocol?
    weak var coordinator: RecipesCoordinator?
}

extension RecipesPresenter: RecipesPresenterProtocol {}
