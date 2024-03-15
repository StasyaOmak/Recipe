// CharacteristicsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с описанием характеристик по БЖУ
final class CharacteristicsTableViewCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static let enercKcal = "Enerc kcal"
        static let carbohydrates = "Carbohydrates"
        static let fats = "Fats"
        static let proteins = "Proteins"
        static let verdana = "Verdana"
        static let verdanaBold = "Verdana-Bold"
    }

    // MARK: - Public Properties

    static let identifier = CharacteristicsTableViewCell.description()

    // MARK: - Visual Components

    private let enercView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.basic.cgColor
        view.backgroundColor = .basic
        return view
    }()

    private let carbohydratesView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.basic.cgColor
        view.backgroundColor = .basic
        return view
    }()

    private let fatsView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.basic.cgColor
        view.backgroundColor = .basic
        return view
    }()

    private let proteinsView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.basic.cgColor
        view.backgroundColor = .basic
        return view
    }()

    private let enercSubView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let carbohydratesSubView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let fatsSubView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    let proteinsSubView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let enercViewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.createFont(name: Constants.verdana, size: 10)
        label.textColor = .white
        label.text = Constants.enercKcal
        return label
    }()

    private let enercSubViewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.createFont(name: Constants.verdana, size: 10)
        label.textColor = .basic
        return label
    }()

    private let carbohydratesViewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.createFont(name: Constants.verdana, size: 10)
        label.textColor = .white
        label.text = Constants.carbohydrates
        return label
    }()

    private let carbohydratesSubViewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.createFont(name: Constants.verdana, size: 10)
        label.textColor = .basic
        return label
    }()

    private let fatsViewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.createFont(name: Constants.verdana, size: 10)
        label.textColor = .white
        label.text = Constants.fats
        return label
    }()

    private let fatsSubViewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.createFont(name: Constants.verdana, size: 10)
        label.textColor = .basic
        return label
    }()

    private let proteinsViewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.createFont(name: Constants.verdana, size: 10)
        label.textColor = .white
        label.text = Constants.proteins
        return label
    }()

    private let proteinsSubViewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.createFont(name: Constants.verdana, size: 10)
        label.textColor = .basic
        return label
    }()

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

    // MARK: - Private Methods

    private func setupView() {
        contentView.clipsToBounds = true
        selectionStyle = .none
        contentView.addSubview(enercView)
        enercView.addSubview(enercSubView)
        contentView.addSubview(carbohydratesView)
        carbohydratesView.addSubview(carbohydratesSubView)
        contentView.addSubview(fatsView)
        fatsView.addSubview(fatsSubView)
        contentView.addSubview(proteinsView)
        proteinsView.addSubview(proteinsSubView)

        enercView.addSubview(enercViewLabel)
        enercSubView.addSubview(enercSubViewLabel)
        carbohydratesView.addSubview(carbohydratesViewLabel)
        carbohydratesSubView.addSubview(carbohydratesSubViewLabel)
        fatsView.addSubview(fatsViewLabel)
        fatsSubView.addSubview(fatsSubViewLabel)
        proteinsView.addSubview(proteinsViewLabel)
        proteinsSubView.addSubview(proteinsSubViewLabel)
    }

    private func setupConstraints() {
        setEnercViewConstraints()
        setCarbohydratesViewConstraints()
        setFatsViewConstraints()
        setProteinsViewConstraints()
        setEnercSubViewConstraints()
        setCarbohydratesSubViewConstraints()
        setFatsSubViewConstraints()
        setProteinsSubViewConstraints()
        setEnercViewLabelConstraints()
        setCarbohydratesViewLabelConstraints()
        setFatsViewLabelConstraints()
        setProteinsViewLabelConstraints()
        setEnercSubViewLabelConstraints()
        setCarbohydratesSubViewLabelConstraints()
        setFatsSubViewLabelConstraints()
        setProteinsSubViewLabelConstraints()
    }

    private func setEnercViewConstraints() {
        enercView.translatesAutoresizingMaskIntoConstraints = false
        enercView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -125).isActive = true
        enercView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        enercView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        enercView.widthAnchor.constraint(equalToConstant: 78).isActive = true
        enercView.heightAnchor.constraint(equalToConstant: 53).isActive = true
    }

    private func setCarbohydratesViewConstraints() {
        carbohydratesView.translatesAutoresizingMaskIntoConstraints = false
        carbohydratesView.leadingAnchor.constraint(equalTo: enercView.trailingAnchor, constant: 5).isActive = true
        carbohydratesView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        carbohydratesView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        carbohydratesView.widthAnchor.constraint(equalToConstant: 78).isActive = true
    }

    private func setFatsViewConstraints() {
        fatsView.translatesAutoresizingMaskIntoConstraints = false
        fatsView.leadingAnchor.constraint(equalTo: carbohydratesView.trailingAnchor, constant: 5).isActive = true
        fatsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        fatsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        fatsView.widthAnchor.constraint(equalToConstant: 78).isActive = true
    }

    private func setProteinsViewConstraints() {
        proteinsView.translatesAutoresizingMaskIntoConstraints = false
        proteinsView.leadingAnchor.constraint(equalTo: fatsView.trailingAnchor, constant: 5).isActive = true
        proteinsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        proteinsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        proteinsView.widthAnchor.constraint(equalToConstant: 78).isActive = true
    }

    private func setEnercSubViewConstraints() {
        enercSubView.translatesAutoresizingMaskIntoConstraints = false
        enercSubView.leadingAnchor.constraint(equalTo: enercView.leadingAnchor).isActive = true
        enercSubView.trailingAnchor.constraint(equalTo: enercView.trailingAnchor).isActive = true
        enercSubView.bottomAnchor.constraint(equalTo: enercView.bottomAnchor).isActive = true
        enercSubView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func setCarbohydratesSubViewConstraints() {
        carbohydratesSubView.translatesAutoresizingMaskIntoConstraints = false
        carbohydratesSubView.leadingAnchor.constraint(equalTo: carbohydratesView.leadingAnchor).isActive = true
        carbohydratesSubView.trailingAnchor.constraint(equalTo: carbohydratesView.trailingAnchor).isActive = true
        carbohydratesSubView.bottomAnchor.constraint(equalTo: carbohydratesView.bottomAnchor).isActive = true
        carbohydratesSubView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func setFatsSubViewConstraints() {
        fatsSubView.translatesAutoresizingMaskIntoConstraints = false
        fatsSubView.leadingAnchor.constraint(equalTo: fatsView.leadingAnchor).isActive = true
        fatsSubView.trailingAnchor.constraint(equalTo: fatsView.trailingAnchor).isActive = true
        fatsSubView.bottomAnchor.constraint(equalTo: fatsView.bottomAnchor).isActive = true
        fatsSubView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func setProteinsSubViewConstraints() {
        proteinsSubView.translatesAutoresizingMaskIntoConstraints = false
        proteinsSubView.leadingAnchor.constraint(equalTo: proteinsView.leadingAnchor).isActive = true
        proteinsSubView.trailingAnchor.constraint(equalTo: proteinsView.trailingAnchor).isActive = true
        proteinsSubView.bottomAnchor.constraint(equalTo: proteinsView.bottomAnchor).isActive = true
        proteinsSubView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func setEnercViewLabelConstraints() {
        enercViewLabel.translatesAutoresizingMaskIntoConstraints = false
        enercViewLabel.leadingAnchor.constraint(equalTo: enercView.leadingAnchor).isActive = true
        enercViewLabel.trailingAnchor.constraint(equalTo: enercView.trailingAnchor).isActive = true
        enercViewLabel.topAnchor.constraint(equalTo: enercView.topAnchor, constant: 8).isActive = true
        enercViewLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }

    private func setCarbohydratesViewLabelConstraints() {
        carbohydratesViewLabel.translatesAutoresizingMaskIntoConstraints = false
        carbohydratesViewLabel.leadingAnchor.constraint(equalTo: carbohydratesView.leadingAnchor).isActive = true
        carbohydratesViewLabel.trailingAnchor.constraint(equalTo: carbohydratesView.trailingAnchor).isActive = true
        carbohydratesViewLabel.topAnchor.constraint(equalTo: carbohydratesView.topAnchor, constant: 8).isActive = true
        carbohydratesViewLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }

    private func setFatsViewLabelConstraints() {
        fatsViewLabel.translatesAutoresizingMaskIntoConstraints = false
        fatsViewLabel.leadingAnchor.constraint(equalTo: fatsView.leadingAnchor).isActive = true
        fatsViewLabel.trailingAnchor.constraint(equalTo: fatsView.trailingAnchor).isActive = true
        fatsViewLabel.topAnchor.constraint(equalTo: fatsView.topAnchor, constant: 8).isActive = true
        fatsViewLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }

    private func setProteinsViewLabelConstraints() {
        proteinsViewLabel.translatesAutoresizingMaskIntoConstraints = false
        proteinsViewLabel.leadingAnchor.constraint(equalTo: proteinsView.leadingAnchor).isActive = true
        proteinsViewLabel.trailingAnchor.constraint(equalTo: proteinsView.trailingAnchor).isActive = true
        proteinsViewLabel.topAnchor.constraint(equalTo: proteinsView.topAnchor, constant: 8).isActive = true
        proteinsViewLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }

    private func setEnercSubViewLabelConstraints() {
        enercSubViewLabel.translatesAutoresizingMaskIntoConstraints = false
        enercSubViewLabel.leadingAnchor.constraint(equalTo: enercView.leadingAnchor).isActive = true
        enercSubViewLabel.trailingAnchor.constraint(equalTo: enercView.trailingAnchor).isActive = true
        enercSubViewLabel.bottomAnchor.constraint(equalTo: enercView.bottomAnchor, constant: -4).isActive = true
        enercSubViewLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

    private func setCarbohydratesSubViewLabelConstraints() {
        carbohydratesSubViewLabel.translatesAutoresizingMaskIntoConstraints = false
        carbohydratesSubViewLabel.leadingAnchor.constraint(equalTo: carbohydratesView.leadingAnchor).isActive = true
        carbohydratesSubViewLabel.trailingAnchor.constraint(equalTo: carbohydratesView.trailingAnchor).isActive = true
        carbohydratesSubViewLabel.bottomAnchor.constraint(equalTo: carbohydratesView.bottomAnchor, constant: -4)
            .isActive = true
        carbohydratesSubViewLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

    private func setFatsSubViewLabelConstraints() {
        fatsSubViewLabel.translatesAutoresizingMaskIntoConstraints = false
        fatsSubViewLabel.leadingAnchor.constraint(equalTo: fatsView.leadingAnchor).isActive = true
        fatsSubViewLabel.trailingAnchor.constraint(equalTo: fatsView.trailingAnchor).isActive = true
        fatsSubViewLabel.bottomAnchor.constraint(equalTo: fatsView.bottomAnchor, constant: -4).isActive = true
        fatsSubViewLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

    private func setProteinsSubViewLabelConstraints() {
        proteinsSubViewLabel.translatesAutoresizingMaskIntoConstraints = false
        proteinsSubViewLabel.leadingAnchor.constraint(equalTo: proteinsView.leadingAnchor).isActive = true
        proteinsSubViewLabel.trailingAnchor.constraint(equalTo: proteinsView.trailingAnchor).isActive = true
        proteinsSubViewLabel.bottomAnchor.constraint(equalTo: proteinsView.bottomAnchor, constant: -4).isActive = true
        proteinsSubViewLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

    // MARK: - Public Methods

    func configure(recipe: FullRecipe?) {
        enercSubViewLabel.text = "\(recipe?.totalCalories ?? 0) kkal"
        carbohydratesSubViewLabel.text = "\(recipe?.totalSugars ?? 0) g"
        fatsSubViewLabel.text = "\(recipe?.totalFat ?? 0) g"
        proteinsSubViewLabel.text = "\(recipe?.totalProtein ?? 0) g"
    }
}
