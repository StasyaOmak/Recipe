// OptionsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка таблицы для размещения опций профиля
final class OptionsTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let verdanaFontName = "Verdana"
    }

    // MARK: - Visual Components

    private let iconView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.backgroundColor = .lightGreenBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.createColor(114, 186, 191, 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let optionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.createFont(name: Constants.verdanaFontName, size: 17)
        label.textColor = .darkGreenText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGreenBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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

    func configure(option: Profile) {
        iconImageView.image = UIImage(systemName: option.imageName)
        optionLabel.text = option.title
        accessoryType = .disclosureIndicator
    }

    // MARK: - Private Methods

    private func setupCell() {
        selectionStyle = .none
        addSubview(iconView)
        addSubview(iconImageView)
        addSubview(optionLabel)
        addSubview(borderView)

        contentView.heightAnchor.constraint(equalToConstant: 80).isActive = true

        setConstraints()
    }

    private func setConstraints() {
        setIconViewConstraints()
        setIconImageViewConstraints()
        setOptionLabelConstraints()
        setBorderViewConstraints()
    }

    private func setIconViewConstraints() {
        iconView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor).isActive = true
    }

    private func setIconImageViewConstraints() {
        iconImageView.centerYAnchor.constraint(equalTo: iconView.centerYAnchor).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: iconView.centerXAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor).isActive = true
    }

    private func setOptionLabelConstraints() {
        optionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        optionLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 10).isActive = true
        optionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        optionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
    }

    private func setBorderViewConstraints() {
        borderView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1).isActive = true
        borderView.leadingAnchor.constraint(equalTo: optionLabel.leadingAnchor).isActive = true
        borderView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        borderView.trailingAnchor.constraint(equalTo: optionLabel.trailingAnchor).isActive = true
    }
}
