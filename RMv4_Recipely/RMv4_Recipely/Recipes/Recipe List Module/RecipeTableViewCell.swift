// RecipeTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка таблицы рецептов
final class RecipeTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let verdanaFontName = "Verdana"
        static let minutesText = "min"
        static let caloriesText = "kcal"
        //    static let
    }

    // MARK: - Visual Components

    private let backgroundCellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.backgroundColor = .lightGreenBackground
        view.layer.borderColor = UIColor.lightGreenBackground.cgColor
        view.layer.borderWidth = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.createFont(name: Constants.verdanaFontName, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.timer
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.createFont(name: Constants.verdanaFontName, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let caloriesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.pizza
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let caloriesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.createFont(name: Constants.verdanaFontName, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let indicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.indicator
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Public Properties

    override var isSelected: Bool {
        didSet {
            super.isSelected = isSelected
            backgroundCellView.layer.borderColor = isSelected ? UIColor.createColor(114, 186, 191, 1).cgColor : UIColor
                .lightGreenBackground.cgColor
        }
    }

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    // MARK: - Public Methods

    func configure(recipe: RecipeDescription) {
        recipeImageView.image = UIImage(named: recipe.imageName)
        titleLabel.text = recipe.title
        timeLabel.text = "\(recipe.time) \(Constants.minutesText)"
        caloriesLabel.text = "\(recipe.value) \(Constants.caloriesText)"
    }

    // MARK: - Private Methods

    private func setupCell() {
        contentView.addSubview(backgroundCellView)
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeImageView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(caloriesImageView)
        contentView.addSubview(caloriesLabel)
        contentView.addSubview(indicatorImageView)
        selectionStyle = .none
        setConstraints()
    }

    private func setConstraints() {
        setRecipeImageViewConstraints()
        setTitleLabelConstraints()
        setBackgroundCellViewConstraints()
        setContentViewConstraints()
        setTimeImageViewConstraints()
        setTimeLabelConstraints()
        setCaloriesImageViewConstraints()
        setCaloriesLabelConstraints()
        setIndicatorImageViewConstraints()
    }

    private func setBackgroundCellViewConstraints() {
        backgroundCellView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        backgroundCellView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        backgroundCellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        backgroundCellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }

    private func setContentViewConstraints() {
        contentView.topAnchor.constraint(equalTo: backgroundCellView.topAnchor, constant: -10).isActive = true
        contentView.bottomAnchor.constraint(equalTo: backgroundCellView.bottomAnchor, constant: 10).isActive = true
    }

    private func setRecipeImageViewConstraints() {
        recipeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        recipeImageView.leadingAnchor.constraint(equalTo: backgroundCellView.leadingAnchor, constant: 10)
            .isActive = true
        recipeImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        recipeImageView.widthAnchor.constraint(equalTo: recipeImageView.heightAnchor).isActive = true
    }

    private func setTitleLabelConstraints() {
        titleLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 170).isActive = true
    }

    private func setTimeImageViewConstraints() {
        timeImageView.topAnchor.constraint(equalTo: centerYAnchor, constant: 10).isActive = true
        timeImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        timeImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        timeImageView.widthAnchor.constraint(equalTo: timeImageView.heightAnchor).isActive = true
    }

    private func setTimeLabelConstraints() {
        timeLabel.centerYAnchor.constraint(equalTo: timeImageView.centerYAnchor).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: timeImageView.trailingAnchor, constant: 4).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 55).isActive = true
    }

    private func setCaloriesImageViewConstraints() {
        caloriesImageView.centerYAnchor.constraint(equalTo: timeImageView.centerYAnchor).isActive = true
        caloriesImageView.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 10).isActive = true
        caloriesImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        caloriesImageView.widthAnchor.constraint(equalTo: caloriesImageView.heightAnchor).isActive = true
    }

    private func setCaloriesLabelConstraints() {
        caloriesLabel.centerYAnchor.constraint(equalTo: timeImageView.centerYAnchor).isActive = true
        caloriesLabel.leadingAnchor.constraint(equalTo: caloriesImageView.trailingAnchor, constant: 4).isActive = true
        caloriesLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        caloriesLabel.widthAnchor.constraint(equalToConstant: 72).isActive = true
    }

    private func setIndicatorImageViewConstraints() {
        indicatorImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        indicatorImageView.trailingAnchor.constraint(equalTo: backgroundCellView.trailingAnchor, constant: -8)
            .isActive = true
        indicatorImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        indicatorImageView.widthAnchor.constraint(equalToConstant: 12.35).isActive = true
    }
}
