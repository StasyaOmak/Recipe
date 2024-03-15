// TitleTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для отображения заголовка и изображения
final class TitleTableViewCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static let cookingTime = "Cooking time"
        static let verdana = "Verdana"
        static let verdanaBold = "Verdana-Bold"
    }

    // MARK: - Public Properties

    static let identifier = TitleTableViewCell.description()

    // MARK: - Visual Components

    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 45
        imageView.clipsToBounds = true
        return imageView
    }()

    private let gramsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .pot
        return imageView
    }()

    private let gramsView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.backgroundColor = .blueForChoose
        return view
    }()

    private let gramsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.createFont(name: Constants.verdana, size: 10)
        label.textColor = .white
        return label
    }()

    private let cookingTimeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .timerDetails
        return imageView
    }()

    private let cookingTimeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.backgroundColor = .blueForChoose
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        return view
    }()

    private let cookingTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.createFont(name: Constants.verdana, size: 10)
        label.textColor = .white
        label.text = Constants.cookingTime
        return label
    }()

    private let cookingTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.createFont(name: Constants.verdana, size: 10)
        label.textColor = .white
        return label
    }()

    private let nameRecipeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.createFont(name: Constants.verdanaBold, size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setConstraints()
    }

    // MARK: - Public Methods

    func configure(recipe: FullRecipe?) {
        nameRecipeLabel.text = recipe?.label
        gramsLabel.text = "\(recipe?.totalWeight ?? 0) g"
        cookingTimeLabel.text = "\(recipe?.totalTime ?? 0) min"
    }

    func setImage(data: Data) {
        recipeImageView.image = UIImage(data: data)
    }

    // MARK: - Private Methods

    private func setupView() {
        contentView.clipsToBounds = true
        selectionStyle = .none
        contentView.addSubview(nameRecipeLabel)
        contentView.addSubview(recipeImageView)
        recipeImageView.addSubview(gramsView)
        gramsView.addSubview(gramsImageView)
        gramsView.addSubview(gramsLabel)
        recipeImageView.addSubview(cookingTimeView)
        cookingTimeView.addSubview(cookingTimeImageView)
        cookingTimeView.addSubview(cookingTimeTitleLabel)
        cookingTimeView.addSubview(cookingTimeLabel)
    }

    private func setConstraints() {
        setCookingTimeLabelConstraints()
        setCookingTimeTitleLabelConstraints()
        setCookingTimeImageViewConstraints()
        setCookingTimeViewConstraints()
        setGramsLabelConstraints()
        setGramsImageViewConstraints()
        setGramsViewConstraints()
        setRecipeImageConstraints()
        setNameRecipeLabelConstraints()
    }

    private func setRecipeImageConstraints() {
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        recipeImageView.topAnchor.constraint(equalTo: nameRecipeLabel.bottomAnchor, constant: 20).isActive = true
        recipeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        recipeImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        recipeImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }

    private func setGramsViewConstraints() {
        gramsView.translatesAutoresizingMaskIntoConstraints = false
        gramsView.topAnchor.constraint(equalTo: recipeImageView.topAnchor, constant: 12).isActive = true
        gramsView.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: -10).isActive = true
        gramsView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        gramsView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setGramsImageViewConstraints() {
        gramsImageView.translatesAutoresizingMaskIntoConstraints = false
        gramsImageView.topAnchor.constraint(equalTo: gramsView.topAnchor, constant: 7).isActive = true
        gramsImageView.trailingAnchor.constraint(equalTo: gramsView.trailingAnchor, constant: -15).isActive = true
        gramsImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        gramsImageView.heightAnchor.constraint(equalToConstant: 17).isActive = true
    }

    private func setGramsLabelConstraints() {
        gramsLabel.translatesAutoresizingMaskIntoConstraints = false
        gramsLabel.topAnchor.constraint(equalTo: gramsView.topAnchor, constant: 28).isActive = true
        gramsLabel.leadingAnchor.constraint(equalTo: gramsView.leadingAnchor, constant: 6).isActive = true
        gramsLabel.widthAnchor.constraint(equalToConstant: 39).isActive = true
        gramsLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

    private func setCookingTimeViewConstraints() {
        cookingTimeView.translatesAutoresizingMaskIntoConstraints = false
        cookingTimeView.bottomAnchor.constraint(equalTo: recipeImageView.bottomAnchor).isActive = true
        cookingTimeView.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor).isActive = true
        cookingTimeView.widthAnchor.constraint(equalToConstant: 124).isActive = true
        cookingTimeView.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }

    private func setCookingTimeImageViewConstraints() {
        cookingTimeImageView.translatesAutoresizingMaskIntoConstraints = false
        cookingTimeImageView.topAnchor.constraint(equalTo: cookingTimeView.topAnchor, constant: 8).isActive = true
        cookingTimeImageView.leadingAnchor.constraint(equalTo: cookingTimeView.leadingAnchor, constant: 12)
            .isActive = true
        cookingTimeImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        cookingTimeImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }

    private func setCookingTimeTitleLabelConstraints() {
        cookingTimeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cookingTimeTitleLabel.topAnchor.constraint(equalTo: cookingTimeView.topAnchor, constant: 10).isActive = true
        cookingTimeTitleLabel.trailingAnchor.constraint(equalTo: cookingTimeView.trailingAnchor, constant: -8)
            .isActive = true
        cookingTimeTitleLabel.widthAnchor.constraint(equalToConstant: 83).isActive = true
        cookingTimeTitleLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

    private func setCookingTimeLabelConstraints() {
        cookingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        cookingTimeLabel.topAnchor.constraint(equalTo: cookingTimeTitleLabel.bottomAnchor).isActive = true
        cookingTimeLabel.leadingAnchor.constraint(equalTo: cookingTimeImageView.trailingAnchor, constant: 15)
            .isActive = true
        cookingTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        cookingTimeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

    private func setNameRecipeLabelConstraints() {
        nameRecipeLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        nameRecipeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        nameRecipeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
    }
}
