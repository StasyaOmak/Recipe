// RecipesCustomCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Ячейка для меню рецептов
final class RecipesCustomCell: UICollectionViewCell {
    // MARK: - Public Properties

    let recipesIdentifier = "cell"

    // MARK: - Visual Components

    private let recipesButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 18
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let recipesView: UIView = {
        let view = UIView()
        view.backgroundColor = .grayTitle
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let recipesLabel: UILabel = {
        let label = UILabel()
        label.text = "RecipesTitle"
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()

        addActionRecipeButtonTapped()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setupViews() {
        contentView.layer.cornerRadius = 18
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 2, height: 5)
        contentView.layer.shadowRadius = 3
        contentView.layer.shadowOpacity = 0.5

        contentView.addSubview(recipesButton)
        recipesButton.addSubview(recipesView)
        recipesView.addSubview(recipesLabel)
    }

    private func setupConstraints() {
        setRecipesButtonConstraints()
        setRecipesViewConstraints()
        setRecipesTitleConstraints()
    }

    private func addActionRecipeButtonTapped() {
        recipesButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    private func setRecipesButtonConstraints() {
        recipesButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        recipesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        recipesButton.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        recipesButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    private func setRecipesViewConstraints() {
        recipesView.leadingAnchor.constraint(equalTo: recipesButton.leadingAnchor).isActive = true
        recipesView.trailingAnchor.constraint(equalTo: recipesButton.trailingAnchor).isActive = true
        recipesView.bottomAnchor.constraint(equalTo: recipesButton.bottomAnchor).isActive = true

        recipesView.heightAnchor.constraint(equalToConstant: contentView.frame.size.height / 5).isActive = true
    }

    private func setRecipesTitleConstraints() {
        recipesLabel.leadingAnchor.constraint(equalTo: recipesView.leadingAnchor).isActive = true
        recipesLabel.trailingAnchor.constraint(equalTo: recipesView.trailingAnchor).isActive = true
        recipesLabel.bottomAnchor.constraint(equalTo: recipesView.bottomAnchor).isActive = true
        recipesLabel.topAnchor.constraint(equalTo: recipesView.topAnchor).isActive = true
    }

    // MARK: - Public Methods

    func setInfo(info: DishCategory) {
        recipesButton.setImage(UIImage(named: info.imageName), for: .normal)
        recipesLabel.text = info.type.rawValue
    }

    @objc func buttonTapped(sender: UIButton) {
        recipesLabel.backgroundColor = .blueForChoose
        recipesButton.layer.borderWidth = 2
        recipesButton.layer.borderColor = .init(red: 0.58, green: 0.76, blue: 0.79, alpha: 1.00)
    }
}
