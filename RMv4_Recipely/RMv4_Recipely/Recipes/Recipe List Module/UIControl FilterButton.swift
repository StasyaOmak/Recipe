// UIControl FilterButton.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кастомный контрол (кнопка фильтра)
final class FilterButton: UIControl {
    // MARK: - Visual Components

    var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        return label
    }()

    var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.stack
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        return imageView
    }()

    // MARK: - Public Properties

    var isPressed: Bool {
        didSet {
            backgroundColor = isPressed ? .basicGreen : .lightGreenBackground
            title.textColor = isPressed ? .white : .black
            iconImageView.image = isPressed ? UIImage.stack2 : UIImage.stack
        }
    }

    var isInIncreaseOrder: Bool {
        didSet {
            let image = UIImage.stack2.cgImage
            guard let image else { return }
            let flippedImage = UIImage(cgImage: image, scale: 3, orientation: .downMirrored)
            iconImageView.image = isInIncreaseOrder ? UIImage.stack : flippedImage
        }
    }

    var isInDecreaseOrder: Bool {
        didSet {
            if let flippedImage = UIImage.stack2.cgImage {
                let flippedImage = UIImage(cgImage: flippedImage, scale: 3, orientation: .downMirrored)
                iconImageView.image = isInDecreaseOrder ? flippedImage : UIImage.stack2
            }
        }
    }

    // MARK: - Initializers

    override init(frame: CGRect) {
        isPressed = false
        isInIncreaseOrder = true
        isInDecreaseOrder = false
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        isPressed = false
        isInIncreaseOrder = true
        isInDecreaseOrder = false
        super.init(coder: coder)
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height * 0.5
    }

    // MARK: - Private Methods

    private func setupView() {
        backgroundColor = .lightGreenBackground
        clipsToBounds = true

        translatesAutoresizingMaskIntoConstraints = false

        heightAnchor.constraint(equalToConstant: 36).isActive = true

        addSubview(title)
        addSubview(iconImageView)

        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14).isActive = true

        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 14).isActive = true
        iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14).isActive = true
        iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor).isActive = true
    }
}
