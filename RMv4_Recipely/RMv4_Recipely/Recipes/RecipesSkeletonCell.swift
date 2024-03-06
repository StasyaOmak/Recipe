// RecipesSkeletonCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка-скелетон для состояния "информация загружается"
final class RecipesSkeletonCell: UICollectionViewCell {
    // MARK: - Visual Components

    private let skeletonLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.lightGreenBackground.cgColor,
            UIColor.white.cgColor,
            UIColor.lightGreenBackground.cgColor
        ]
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.locations = [0.35, 0.50, 0.65]
        return layer
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    // MARK: - Private Methods

    private func setupCell() {
        contentView.layer.addSublayer(skeletonLayer)
        skeletonLayer.frame = contentView.bounds
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        contentView.backgroundColor = .lightGreenBackground

        let animationGroup = makeAnimation()
        animationGroup.beginTime = 0.0
        skeletonLayer.add(animationGroup, forKey: "backgroundColor")
    }

    private func makeAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 3
        animation.repeatCount = Float.infinity
        animation.autoreverses = false
        animation.fromValue = -frame.width
        animation.toValue = frame.width
        animation.isRemovedOnCompletion = false
        animation.fillMode = .both
        return animation
    }
}
