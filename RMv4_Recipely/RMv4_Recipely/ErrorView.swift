//
//  ErrorView.swift
//  RMv4_Recipely
//
//  Created by Anastasiya Omak on 14/03/2024.
//

import UIKit

class ErrorView: UIView {

    enum Constants {
        static let reloadButtonText = "Reload"
        static let emptyDataText = "Failed to load data"
        static let verdanaBoldFontName = "Verdana-Bold"
        static let verdanaFontName = "Verdana"
    }

    private lazy var backgroundLightningView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 12
        return view
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.verdanaFontName, size: 14)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()

    private lazy var reloadButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.reloadButtonText, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.verdanaFontName, size: 14)
        button.setTitleColor(.lightGray, for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = .darkGray
        button.setImage(UIImage(named: "reload"), for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        button.contentHorizontalAlignment = .center
        return button
    }()

    private let errorView = UIView()

    private let errorImageView = UIImageView(image: UIImage(named: "lightning"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureErrorView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureErrorView() {
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
}
