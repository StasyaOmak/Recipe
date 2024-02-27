// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol ProfileViewControllerProtocol: AnyObject {}

/// Экран данных пользователя
final class ProfileViewController: UIViewController {
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

    var presenter: ProfilePresenterProtocol?

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

extension ProfileViewController: ProfileViewControllerProtocol {}
