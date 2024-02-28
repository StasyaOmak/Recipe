// BonusesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс вью модуля "Бонусы"
protocol BonusesViewControllerProtocol: AnyObject {
    /// Свойство-презентер
    var bonusesPresenter: BonusesPresenterProtocol? { get set }
}

/// Экран бонусов пользователя
final class BonusesViewController: UIViewController {
    var bonusesPresenter: BonusesPresenterProtocol?

    // MARK: - Constants

    private enum Constants {
        static let bonusesImageName = "bonus box"
        static let bonusesTitleText = "Your bonuses"
        static let starImageName = "star 2"
        static let verdanaBoldFontName = "Verdana-Bold"
        static let bonusesCount = "100"
    }

    // MARK: - Visual Components

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let bonusesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.bonusesTitleText
        label.textColor = .darkGreenText
        label.font = UIFont(name: Constants.verdanaBoldFontName, size: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let bonusesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.bonusesImageName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.starImageName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let bonusesAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.verdanaBoldFontName, size: 30)
        label.textColor = .darkGreenText
        label.text = Constants.bonusesCount
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(closeButton)
        view.addSubview(bonusesTitleLabel)
        view.addSubview(bonusesImageView)
        view.addSubview(starImageView)
        view.addSubview(bonusesAmountLabel)

        setConstraints()
    }

    private func setConstraints() {
        setCloseButtonConstraints()
        setBonusesTitleLabelConstraints()
        setBonusesImageViewConstraints()
        setStarImageViewConstraints()
        setBonusesAmountLabelConstraints()
    }

    private func setCloseButtonConstraints() {
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor).isActive = true
    }

    private func setBonusesTitleLabelConstraints() {
        bonusesTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        bonusesTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        bonusesTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        bonusesTitleLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }

    private func setBonusesImageViewConstraints() {
        bonusesImageView.topAnchor.constraint(equalTo: bonusesTitleLabel.bottomAnchor, constant: 13).isActive = true
        bonusesImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    private func setStarImageViewConstraints() {
        starImageView.topAnchor.constraint(equalTo: bonusesImageView.bottomAnchor, constant: 28).isActive = true
        starImageView.trailingAnchor.constraint(equalTo: bonusesImageView.centerXAnchor, constant: -20).isActive = true

        starImageView.widthAnchor.constraint(equalToConstant: 29.17).isActive = true
        starImageView.heightAnchor.constraint(equalToConstant: 27.71).isActive = true
    }

    private func setBonusesAmountLabelConstraints() {
        bonusesAmountLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor).isActive = true
        bonusesAmountLabel.leadingAnchor.constraint(equalTo: bonusesImageView.centerXAnchor, constant: 2)
            .isActive = true
        bonusesAmountLabel.trailingAnchor.constraint(equalTo: bonusesImageView.trailingAnchor, constant: 20)
            .isActive = true
        bonusesAmountLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }

    @objc private func closeScreen() {
        bonusesPresenter?.closeButtonTapped()
    }
}

extension BonusesViewController: BonusesViewControllerProtocol {}
