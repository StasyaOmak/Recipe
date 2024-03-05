// TermsOfUseView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс вью модуля "Политики использования"
protocol TermsOfUseViewControllerProtocol: AnyObject {
    /// Свойство-презентер
    var termOfUsePresenter: TermsOfUsePresenterProtocol? { get set }
//    func showUserInfo()
}

final class TermsOfUseView: UIView {
    var termOfUsePresenter: TermsOfUsePresenterProtocol?

    // MARK: - Constants

    private enum Constants {
        static let termOfUseTitleText = "Terms of Use"
        static let termOfUseText = """
        1/2 to 2 fish heads, depending on size, about 5 pounds total
        2 tablespoons vegetable oil
        1/4 cup red or green thai curry paste
        3 tablespoons fish sauce or anchovy sauce
        1 tablespoon sugar
        1 can coconut milk, about 12 ounces
        3 medium size asian eggplants, cut int 1 inch rounds
        Handful of bird's eye chilies
        1/2 cup thai basil leaves
        Juice of 3 limes
        1/2 to 2 fish heads, depending on size, about 5 pounds total
        2 tablespoons vegetable oil
        1/4 cup red or green thai curry paste
        3 tablespoons fish sauce or anchovy sauce
        1 tablespoon sugar
        1 can coconut milk, about 12 ounces
        3 medium size asian eggplants, cut int 1 inch rounds
        Handful of bird's eye chilies
        1/2 cup thai basil leaves
        Juice of 3 limes
        1/2 to 2 fish heads, depending on size, about 5 pounds total
        2 tablespoons vegetable oil
        1/4 cup red or green thai curry paste
        3 tablespoons fish sauce or anchovy sauce
        1 tablespoon sugar
        1 can coconut milk, about 12 ounces
        3 medium size asian eggplants, cut int 1 inch rounds
        Handful of bird's eye chilies
        1/2 cup thai basil leaves
        Juice of 3 limes
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
        label.font = UIFont(name: Constants.verdanaBoldFontName, size: 20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let termsOfUseTextLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.termOfUseText
        label.textColor = .black
        label.font = UIFont(name: Constants.verdanaName, size: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureView()
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
        layer.cornerRadius = 30
    }
    
    private func setHandleAreaConstraints() {
        handleAreaView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        handleAreaView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        handleAreaView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        handleAreaView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setLineAreaConstraints() {
        lineImageView.topAnchor.constraint(equalTo: handleAreaView.topAnchor, constant: 10).isActive = true
        lineImageView.centerXAnchor.constraint(equalTo: handleAreaView.centerXAnchor).isActive = true
        lineImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        lineImageView.heightAnchor.constraint(equalToConstant: 5).isActive = true
    }
    

    private func setCloseButtonConstraints() {
        closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
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
        termsOfUseTitleLabel.topAnchor.constraint(equalTo: termsOfUseTitleLabel.bottomAnchor, constant: 20)
            .isActive = true
        termsOfUseTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        termsOfUseTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        termsOfUseTitleLabel.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }

    @objc private func closeScreen() {
        termOfUsePresenter?.closeButtonTapped()
    }
}

// - MARK: Extension BonusesViewController + BonusesViewControllerProtocol
extension TermsOfUseView: TermsOfUseViewControllerProtocol {
//    func showUserInfo() {
//
//    }

//    func showUserInfo(user: User) {
//        bonusesAmountLabel.text = "\(user.bonusesCount)"
}
