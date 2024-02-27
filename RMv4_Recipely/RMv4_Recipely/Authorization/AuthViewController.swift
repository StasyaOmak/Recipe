// AuthViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol AuthViewControllerProtocol: AnyObject {}

/// Экран авторизации
final class AuthViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        //    static let
        //    static let
        //    static let
        //    static let
    }

    // MARK: - Visual Components

    // MARK: - Public Properties

    var presenter: AuthPresenterProtocol?

    // MARK: - Private Properties

    // MARK: - Initializers

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }

    // MARK: - Public Methods

    // MARK: - IBAction

    // MARK: - Private Methods
}

extension AuthViewController: AuthViewControllerProtocol {}
