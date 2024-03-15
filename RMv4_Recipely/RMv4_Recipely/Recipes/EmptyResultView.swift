// EmptyResultView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class EmptyResultView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let verdanaFontName = "Verdana"
        static let verdanaBoldFontName = "Verdana-Bold"
    }

    private let errorTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.verdanaBoldFontName, size: 14)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = "Nothing found"
        return label
    }()

    private let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.verdanaFontName, size: 12)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.text = "Try entering your query differently"
        label.numberOfLines = 4
        return label
    }()

    private lazy var scopeBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightBlueBackground
        view.layer.cornerRadius = 12
        return view
    }()

    private let searchImageView = UIImageView(image: UIImage(named: "search"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        addSubview(scopeBackgroundView)
        addSubview(searchImageView)
        addSubview(errorTitleLabel)
        addSubview(errorMessageLabel)
        scopeBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        searchImageView.translatesAutoresizingMaskIntoConstraints = false
        errorTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        createViewConstraints()
        createBackgroundViewConstraints()
        createErrorImageViewConstraints()
        createTitlelabelConstraints()
        createMessagelabelConstraints()
    }

    private func createViewConstraints() {
        widthAnchor.constraint(equalToConstant: 350).isActive = true
        heightAnchor.constraint(equalToConstant: 140).isActive = true
    }

    private func createBackgroundViewConstraints() {
        scopeBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        scopeBackgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scopeBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        scopeBackgroundView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        scopeBackgroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func createErrorImageViewConstraints() {
        searchImageView.translatesAutoresizingMaskIntoConstraints = false
        searchImageView.centerYAnchor.constraint(equalTo: scopeBackgroundView.centerYAnchor).isActive = true
        searchImageView.centerXAnchor.constraint(equalTo: scopeBackgroundView.centerXAnchor).isActive = true
        searchImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        searchImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }

    private func createTitlelabelConstraints() {
        errorTitleLabel.topAnchor.constraint(equalTo: scopeBackgroundView.bottomAnchor, constant: 4).isActive = true
        errorTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
        errorTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4).isActive
            = true
    }

    private func createMessagelabelConstraints() {
        errorMessageLabel.topAnchor.constraint(equalTo: errorTitleLabel.bottomAnchor, constant: 4).isActive = true
        errorMessageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
        errorMessageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4).isActive
            = true
    }
}
