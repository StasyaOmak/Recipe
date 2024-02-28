// AuthViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран авторизации
final class AuthViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let loginText = "Login"
        static let emailAddressText = "Email Address"
        static let verdana = "Verdana"
        static let verdanaBold = "Verdana-Bold"

        static let passwordText = "Password"
        static let incorrectFormatText = "Incorrect format"
        static let wrongPasswordText = "You entered the wrong password"
        static let emailAddressPlaceholderText = "Enter Email Address"
        static let passwordPlaceholderText = "Enter Password"

        static let loginButtonText = "Login"
        static let errorMessageText = "Please check the accuracy of the\n entered credentials."
    }

    // MARK: - Visual Components

    private lazy var loginLabel: UILabel = {
        let element = UILabel()
        element.text = Constants.loginText
        element.textColor = .darkGray
        element.font = UIFont(name: Constants.verdanaBold, size: 28)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var emailAdressLabel: UILabel = {
        let element = UILabel()
        element.text = Constants.emailAddressText
        element.textColor = .darkGray
        element.font = UIFont(name: Constants.verdanaBold, size: 18)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var passwordLabel: UILabel = {
        let element = UILabel()
        element.text = Constants.passwordText
        element.textColor = .darkGray
        element.font = UIFont(name: Constants.verdanaBold, size: 18)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var incorrectFormatLabel: UILabel = {
        let element = UILabel()
        element.text = Constants.incorrectFormatText
        element.textColor = .red
        element.isHidden = true
        element.font = UIFont(name: Constants.verdana, size: 12)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var wrongPasswordLabel: UILabel = {
        let element = UILabel()
        element.text = Constants.wrongPasswordText
        element.textColor = .red
        element.isHidden = true
        element.font = UIFont(name: Constants.verdana, size: 12)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    lazy var emailAddressTextField: UITextField = {
        let element = UITextField()
        element.placeholder = Constants.emailAddressPlaceholderText
        element.font = UIFont(name: Constants.verdana, size: 18)
        element.borderStyle = .roundedRect
        element.delegate = self

        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let imageView = UIImageView(frame: CGRect(x: 6, y: 6, width: 20, height: 18))
        imageView.image = UIImage(named: "envelope")
        leftView.addSubview(imageView)

        element.leftView = leftView
        element.leftViewMode = .always
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    lazy var passwordTextField: UITextField = {
        let element = UITextField()
        element.placeholder = Constants.passwordPlaceholderText
        element.font = UIFont(name: Constants.verdana, size: 18)
        element.borderStyle = .roundedRect
        element.delegate = self

        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let imageView = UIImageView(frame: CGRect(x: 6, y: 6, width: 20, height: 18))
        imageView.image = UIImage(named: "lock")
        leftView.addSubview(imageView)

        element.leftView = leftView
        element.leftViewMode = .always

        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let button = UIButton(frame: CGRect(x: 6, y: 6, width: 20, height: 20))
        button.setImage(.vector, for: .normal)
        rightView.addSubview(button)
        element.rightView = rightView
        element.rightViewMode = .always
        //        element.addTarget(self, action: #selector(hideButtonPressed), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false

        return element
    }()

    private lazy var loginButton: UIButton = {
        let element = UIButton()
        element.setTitle(Constants.loginButtonText, for: .normal)
        element.backgroundColor = .buttonMain
        element.titleLabel?.font = UIFont(name: Constants.verdana, size: 16)
        element.setTitleColor(.white, for: .normal)
        element.layer.cornerRadius = 12
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(
            self,
            action: #selector(loginButtonTapped(_:)),
            for: .touchUpInside
        )
        return element
    }()

    private lazy var errorMessageLabel: UILabel = {
        let element = UILabel()
        element.text = Constants.errorMessageText
        element.textColor = .white
        element.textAlignment = .center
        element.numberOfLines = 0
        element.backgroundColor = .warningLabel
        element.layer.masksToBounds = true
        element.isHidden = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.cornerRadius = 12

        return element
    }()

    private lazy var gradientLayer: CAGradientLayer = {
        let element = CAGradientLayer()
        element.frame = view.bounds
        element.colors = [
            UIColor.white.cgColor,
            UIColor.gradientLayer.cgColor,
        ]
        return element
    }()

    // MARK: - Public Properties

    var presenter: AuthPresenterProtocol?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupAllConstraints()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }

    // MARK: - Private Methods

    private func setupViews() {
        view.layer.addSublayer(gradientLayer)
        view.addSubview(loginLabel)
        view.addSubview(emailAdressLabel)
        view.addSubview(passwordLabel)
        view.addSubview(incorrectFormatLabel)
        view.addSubview(wrongPasswordLabel)
        view.addSubview(emailAddressTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(errorMessageLabel)
    }

    @objc private func handleTap() {
        view.endEditing(true) // Скрыть клавиатуру
        loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            .isActive = true
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        loginButton.translatesAutoresizingMaskIntoConstraints = true
        loginButton.frame.origin.y = wrongPasswordLabel.frame.origin.y
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.frame.origin.y = view.frame.size.height - 200
    }

    @objc private func loginButtonTapped(_ sender: UIButton) {
        loginButton.setTitle("", for: .normal)
        loginButton.setImage(UIImage(systemName: "slowmo"), for: .normal)
        loginButton.tintColor = .white
        UIView.animate(withDuration: 3.0) {
            sender.imageView?.transform = CGAffineTransform(
                rotationAngle: CGFloat.pi
            )
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            UIView.animate(withDuration: 1.0) {
                self.errorMessageLabel.isHidden = false
            }
        }
    }

    private func setupLoginLabelConstraints() {
        loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 82).isActive = true
    }

    private func setupEmailAddressConstraints() {
        emailAdressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailAdressLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 137).isActive = true
    }

    private func setPasswordConstraints() {
        passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 248).isActive = true
    }

    private func setIncorrectFormatConstraints() {
        incorrectFormatLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        incorrectFormatLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 225).isActive = true
    }

    private func setWrongPasswordConstraints() {
        wrongPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        wrongPasswordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 338).isActive = true
    }

    private func setEmailAddressTextFieldConstraints() {
        emailAddressTextField.translatesAutoresizingMaskIntoConstraints = false
        emailAddressTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailAddressTextField.topAnchor.constraint(equalTo: emailAdressLabel.bottomAnchor, constant: 7).isActive = true
        emailAddressTextField.widthAnchor.constraint(equalToConstant: 350).isActive = true
        emailAddressTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setPasswordTextFieldConstraints() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 7).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 350).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setLoginButtonConstraints() {
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 350).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
            .isActive = true
    }

    private func setupWarningLabelPassConstraints() {
        errorMessageLabel.bottomAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: -15).isActive = true
        errorMessageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        errorMessageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        errorMessageLabel.heightAnchor.constraint(equalToConstant: 87).isActive = true
    }

    private func setupAllConstraints() {
        setupLoginLabelConstraints()
        setupEmailAddressConstraints()
        setPasswordConstraints()
        setIncorrectFormatConstraints()
        setWrongPasswordConstraints()
        setEmailAddressTextFieldConstraints()
        setPasswordTextFieldConstraints()
        setLoginButtonConstraints()
        setupWarningLabelPassConstraints()
    }
}

extension AuthViewController: AuthViewControllerProtocol {
    func setPasswordColor(color: UIColor, isValidate: Bool, borderColor: UIColor) {
        passwordLabel.textColor = color
        passwordTextField.layer.borderColor = borderColor.cgColor
        wrongPasswordLabel.isHidden = isValidate
    }

    func setLoginColor(color: UIColor, isValidate: Bool, borderColor: UIColor) {
        emailAdressLabel.textColor = color
        emailAddressTextField.layer.borderColor = borderColor.cgColor
        incorrectFormatLabel.isHidden = isValidate
    }
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter?.checkLogin(login: emailAddressTextField.text)
        presenter?.checkPassword(password: passwordTextField.text)
    }
}

extension AuthViewController {
    func upView(_ keyboardHeight: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y -= keyboardHeight
        }
    }

    func downView(_ keyboardHeight: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y += keyboardHeight
        }
    }
}
