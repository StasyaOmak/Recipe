// HeaderTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Первая ячейка профиля пользователя, содержит аватар, имя и кнопку редактирования имени.
final class HeaderTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let verdanaBoldFontName = "Verdana-Bold"
        static let editButtonImageName = "pencil"
    }

    // MARK: - Visual Components

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .basicGreen
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 80
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor.basicGreen.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGreenText
        label.font = UIFont(name: Constants.verdanaBoldFontName, size: 25)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var editNameButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.editButtonImageName), for: .normal)
        button.setImage(
            UIImage(named: Constants.editButtonImageName)?.withTintColor(.basicGreen, renderingMode: .alwaysTemplate),
            for: .highlighted
        )
        button.addTarget(self, action: #selector(editName), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Public Properties

    var editNameHandler: (() -> ())?

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

    func configure(user: User) {
        avatarImageView.image = UIImage(named: user.avatarImageName)
        usernameLabel.text = user.name
    }

    // MARK: - Private Methods

    private func setupCell() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        contentView.addSubview(editNameButton)

        selectionStyle = .none

        contentView.heightAnchor.constraint(equalToConstant: 250).isActive = true

        setAvatarImageViewConstraints()
        setUsernameLabelConstraints()
        setEditNameButtonConstraints()
    }

    private func setAvatarImageViewConstraints() {
        avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor).isActive = true
    }

    private func setUsernameLabelConstraints() {
        usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 30).isActive = true
        usernameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        usernameLabel.widthAnchor.constraint(equalToConstant: 175).isActive = true
    }

    private func setEditNameButtonConstraints() {
        editNameButton.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        editNameButton.leadingAnchor.constraint(equalTo: usernameLabel.trailingAnchor, constant: 10).isActive = true
        editNameButton.heightAnchor.constraint(equalToConstant: 18).isActive = true
        editNameButton.widthAnchor.constraint(equalTo: editNameButton.heightAnchor).isActive = true
    }

    @objc private func editName() {
        editNameHandler?()
    }
}
