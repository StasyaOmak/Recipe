// EmptyResultTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка-заглушка для непришедшего результата поиска
final class EmptyResultTableViewCell: UITableViewCell {
    // MARK: - Visual Components

    private let emptyResultView = EmptyResultView()

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
        contentView.addSubview(emptyResultView)
        contentView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        selectionStyle = .none
        emptyResultView.translatesAutoresizingMaskIntoConstraints = false
        emptyResultView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emptyResultView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
