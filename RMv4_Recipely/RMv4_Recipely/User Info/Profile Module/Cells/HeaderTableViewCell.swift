// HeaderTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Первая ячейка профиля пользователя, содержит аватар, имя и кнопку редактирования имени.
final class HeaderTableViewCell: UITableViewCell {
    // MARK: - Types

    // swiftlint:disable custom_custom_void_handler
    typealias VoidHandler = () -> ()
    // swiftlint:enable custom_custom_void_handler

    // MARK: - Constants

    private enum Constants {
        static let verdanaBoldFontName = "Verdana-Bold"
        static let editButtonImageName = "pencil"
    }

    // MARK: - Visual Components

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.createColor(114, 186, 191, 1)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 80
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor.createColor(114, 186, 191, 1).cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(changeName))
        imageView.addGestureRecognizer(tap)
        return imageView
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGreenText
        label.font = UIFont.createFont(name: Constants.verdanaBoldFontName, size: 25)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var editNameButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.editButtonImageName), for: .normal)
        button.setImage(
            UIImage(named: Constants.editButtonImageName)?.withTintColor(
                UIColor.createColor(114, 186, 191, 1),
                renderingMode: .alwaysTemplate
            ),
            for: .highlighted
        )
        button.addTarget(self, action: #selector(editName), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Public Properties

    var editNameHandler: VoidHandler?
    var changePhotoHandler: VoidHandler?

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
        usernameLabel.text = user.name
        guard let data = user.avatarImageData else { return }
        avatarImageView.image = UIImage(data: data)
    }

    // MARK: - Private Methods

    private func setupCell() {
        selectionStyle = .none
        contentView.heightAnchor.constraint(equalToConstant: 250).isActive = true

        contentView.addSubview(avatarImageView)
        addSubview(usernameLabel)
        contentView.addSubview(editNameButton)

        setConstraints()
    }

    private func setConstraints() {
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
    }

    private func setEditNameButtonConstraints() {
        editNameButton.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        editNameButton.leadingAnchor.constraint(equalTo: usernameLabel.trailingAnchor, constant: 16).isActive = true
        editNameButton.heightAnchor.constraint(equalToConstant: 18).isActive = true
        editNameButton.widthAnchor.constraint(equalTo: editNameButton.heightAnchor).isActive = true
        editNameButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -10).isActive = true
    }

    private func loadImageFromDiskWith(fileName: String) -> UIImage? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory

        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)

        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }

        return nil
    }

    @objc private func editName() {
        editNameHandler?()
    }

    @objc private func changeName() {
        changePhotoHandler?()
    }
}
