// ErrorTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для состояния .error
final class ErrorTableViewCell: UITableViewCell {
    // MARK: - Visual Components

    private let errorView = ErrorView()

    // MARK: - Private Properties

    var reloadButtonHandler: (() -> ())?

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        contentView.addSubview(errorView)
        selectionStyle = .none
        errorView.reloadButtonHandler = reloadButtonHandler
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        errorView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        errorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        errorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
