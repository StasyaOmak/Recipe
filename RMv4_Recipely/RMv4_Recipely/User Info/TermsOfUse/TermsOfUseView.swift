// TermsOfUseView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс вью модуля "Политики использования"
protocol TermsOfUseViewControllerProtocol: AnyObject {
    /// Свойство-презентер
    var termOfUsePresenter: TermsOfUsePresenterProtocol? { get set }
}

final class TermsOfUseView: UIView {
    var termOfUsePresenter: TermsOfUsePresenterProtocol?

    // MARK: - Constants

    private enum Constants {
        static let termOfUseTitleText = "Terms of Use"
        static let termOfUseText = """
        Welcome to our recipe app! We're thrilled 
        to have you on board. To ensure a delightful
        experience for everyone, please take a moment
        to familiarize yourself with our rules:
        User Accounts:
        - Maintain one account per user.
        - Safeguard your login credentials; don't share them with others.
        Content Usage:
        - Recipes and content are for personal use only.
        - Do not redistribute or republish recipes without proper attribution.
        Respect Copyright:
        - Honor the copyright of recipe authors and contributors.
        - Credit the original source when adapting or modifying a recipe.
        Community Guidelines:
        - Show respect in community features.
        -mAvoid offensive language or content that violates community standards.
        Feedback and Reviews:
        - Share constructive feedback and reviews.
        - Do not submit false or misleading information.
        Data Privacy:
        - Review and understand our privacy policy regarding data collection and usage.
        Compliance with Laws:
        - Use the app in compliance with all applicable laws and regulations.
        Updates to Terms:
        - Stay informed about updates; we'll notify you of any changes.
        By using our recipe app, you agree to adhere to these rules.
        Thank you for being a part of our culinary community!
        Enjoy exploring and cooking up a storm!
        """
        static let verdanaBoldFontName = "Verdana-Bold"
        static let verdanaName = "Verdana"
        static let lineImageName = "line"
    }

    // MARK: - Visual Components

    let handleAreaView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()

    private let lineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Constants.lineImageName)
        return imageView
    }()

    private let termsOfUseTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.termOfUseTitleText
        label.textColor = .black
        label.font = UIFont.createFont(name: Constants.verdanaBoldFontName, size: 20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let termsOfUseTextLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.termOfUseText
        label.textColor = .black
        label.font = UIFont.createFont(name: Constants.verdanaName, size: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureView()
        backgroundColor = .white
        handleAreaView.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        configureView()
    }

    func setGesture(gestures: [UIGestureRecognizer]) {
        for gesture in gestures {
            handleAreaView.addGestureRecognizer(gesture)
        }
    }

    // MARK: - Private Methods

    private func setupUI() {
        backgroundColor = .white
        addSubview(closeButton)
        addSubview(termsOfUseTitleLabel)
        addSubview(termsOfUseTextLabel)
        addSubview(handleAreaView)
        handleAreaView.addSubview(lineImageView)

        setConstraints()

        layer.cornerRadius = 20
        handleAreaView.clipsToBounds = true
    }

    private func setConstraints() {
        setCloseButtonConstraints()
        setTermsOfUseTitleLabelConstraints()
        setTermsOfUseTextLabelConstraints()
        setHandleAreaConstraints()
        setLineAreaConstraints()
    }

    private func configureView() {
        isUserInteractionEnabled = true
        backgroundColor = .white
    }

    private func setHandleAreaConstraints() {
        handleAreaView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        handleAreaView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        handleAreaView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        handleAreaView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func setLineAreaConstraints() {
        lineImageView.topAnchor.constraint(equalTo: handleAreaView.topAnchor, constant: 10).isActive = true
        lineImageView.centerXAnchor.constraint(equalTo: handleAreaView.centerXAnchor).isActive = true
        lineImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        lineImageView.heightAnchor.constraint(equalToConstant: 5).isActive = true
    }

    private func setCloseButtonConstraints() {
        closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor).isActive = true
    }

    private func setTermsOfUseTitleLabelConstraints() {
        termsOfUseTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        termsOfUseTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        termsOfUseTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        termsOfUseTitleLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }

    private func setTermsOfUseTextLabelConstraints() {
        termsOfUseTextLabel.topAnchor.constraint(equalTo: termsOfUseTitleLabel.bottomAnchor, constant: 20)
            .isActive = true
        termsOfUseTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        termsOfUseTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        termsOfUseTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }

    @objc private func closeScreen() {
        termOfUsePresenter?.closeButtonTapped()
    }
}

// - MARK: Extension BonusesViewController + BonusesViewControllerProtocol
extension TermsOfUseView: TermsOfUseViewControllerProtocol {}
