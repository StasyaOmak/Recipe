// FullDescriptionTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с описанием рецепта
final class FullDescriptionTableViewCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static let verdana = "Verdana"
        static let verdanaBold = "Verdana-Bold"
    }

    // MARK: - Visual Components

    private let backgroundColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .basicGreen
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let textRecipeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Constants.verdana, size: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.gradientLayer.cgColor,
            UIColor.white.cgColor,
        ]
        return gradientLayer
    }()

    // MARK: - Public Properties

    static let identifier = FullDescriptionTableViewCell.description()

    // MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradientLayer.frame = backgroundColorView.bounds
    }

    // MARK: - Private Methods

    private func setupView() {
        backgroundColorView.layer.addSublayer(gradientLayer)
        contentView.addSubview(backgroundColorView)
        contentView.addSubview(textRecipeLabel)
    }

    private func setupConstraints() {
        setBackgroundColorViewConstraints()
        setTextRecipeLabelConstraints()
    }

    private func setBackgroundColorViewConstraints() {
        backgroundColorView.topAnchor.constraint(equalTo: textRecipeLabel.topAnchor, constant: -27).isActive = true
        backgroundColorView.bottomAnchor.constraint(equalTo: textRecipeLabel.bottomAnchor, constant: 27)
            .isActive = true
        backgroundColorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        backgroundColorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }

    private func setTextRecipeLabelConstraints() {
        textRecipeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27).isActive = true
        textRecipeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -27).isActive = true
        textRecipeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 27).isActive = true
        textRecipeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -27).isActive = true
    }

    // MARK: - Public Methods

    func configure(recipe: RecipeDescription?) {
        textRecipeLabel.text = recipe?.descriptions
    }
}
