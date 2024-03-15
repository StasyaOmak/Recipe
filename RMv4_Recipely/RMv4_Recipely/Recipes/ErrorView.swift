// ErrorView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Переиспользуемая вью-заглушка для состояния контролеров, когда данные не пришли
final class ErrorView: UIView {
    // MARK: - Constants

    enum Constants {
        static let reloadButtonText = "Reload"
        static let emptyDataText = "Failed to load data"
        static let verdanaBoldFontName = "Verdana-Bold"
        static let verdanaFontName = "Verdana"
    }

    // MARK: - Visual Components

    private lazy var backgroundLightningView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightBlueBackground
        view.layer.cornerRadius = 12
        return view
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.verdanaFontName, size: 14)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.text = "Failed to load data"
        return label
    }()

    private lazy var reloadButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.reloadButtonText, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.verdanaFontName, size: 14)
        button.setTitleColor(.lightGray, for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = .lightBlueBackground
        button.setImage(UIImage(named: "reload"), for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
        return button
    }()

    private let errorView = UIView()

    private let errorImageView = UIImageView(image: UIImage(named: "lightning"))

    // MARK: - Public Properties

    var reloadButtonHandler: (() -> ())?

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureErrorView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureErrorView()
    }

    // MARK: - Private Methods

    private func configureErrorView() {
        isUserInteractionEnabled = true
        errorView.isUserInteractionEnabled = true
        addSubview(errorView)
        errorView.addSubview(backgroundLightningView)
        errorView.addSubview(errorImageView)
        errorView.addSubview(errorLabel)
        errorView.addSubview(reloadButton)
        createErrorViewConstraints()
        createBackgroundLightningViewConstraints()
        createErrorImageViewConstraints()
        createErrorLabelConstraints()
        createReloadButtonConstraints()
    }

    private func createErrorViewConstraints() {
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 8).isActive = true
        errorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        errorView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        errorView.heightAnchor.constraint(equalToConstant: 140).isActive = true
    }

    private func createBackgroundLightningViewConstraints() {
        backgroundLightningView.translatesAutoresizingMaskIntoConstraints = false
        backgroundLightningView.topAnchor.constraint(equalTo: errorView.topAnchor).isActive = true
        backgroundLightningView.centerXAnchor.constraint(equalTo: errorView.centerXAnchor).isActive = true
        backgroundLightningView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        backgroundLightningView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func createErrorImageViewConstraints() {
        errorImageView.translatesAutoresizingMaskIntoConstraints = false
        errorImageView.centerYAnchor.constraint(equalTo: backgroundLightningView.centerYAnchor).isActive = true
        errorImageView.centerXAnchor.constraint(equalTo: backgroundLightningView.centerXAnchor).isActive = true
        errorImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        errorImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }

    private func createErrorLabelConstraints() {
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.topAnchor.constraint(equalTo: backgroundLightningView.bottomAnchor, constant: 17).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: errorView.centerXAnchor).isActive = true
        errorLabel.widthAnchor.constraint(equalTo: errorView.widthAnchor).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }

    private func createReloadButtonConstraints() {
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        reloadButton.bottomAnchor.constraint(equalTo: errorView.bottomAnchor).isActive = true
        reloadButton.centerXAnchor.constraint(equalTo: errorView.centerXAnchor).isActive = true
        reloadButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        reloadButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }

    @objc private func reloadButtonTapped() {
        reloadButtonHandler?()
    }
}
