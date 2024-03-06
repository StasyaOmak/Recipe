// AuthViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол экрана модуля "Авторизация"
protocol AuthViewProtocol: AnyObject {
    /// установка цвета для поля ввода логина
    func setLoginColor(color: String, isValidate: Bool, borderColor: String)
    /// установка цвета для поля ввода пароля
    func setPasswordColor(color: String, isValidate: Bool, borderColor: String)
    /// функция вызова уведомления об ошибке ввода данных
    func showEntryErrorMessage()
}

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

    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.loginText
        label.textColor = .darkGray
        label.font = UIFont.createFont(name: Constants.verdanaBold, size: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let emailAdressLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.emailAddressText
        label.textColor = .darkGray
        label.font = UIFont.createFont(name: Constants.verdanaBold, size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.passwordText
        label.textColor = .darkGray
        label.font = UIFont.createFont(name: Constants.verdanaBold, size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let incorrectFormatLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.incorrectFormatText
        label.textColor = .red
        label.isHidden = true
        label.font = UIFont.createFont(name: Constants.verdana, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let wrongPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.wrongPasswordText
        label.textColor = .red
        label.isHidden = true
        label.font = UIFont.createFont(name: Constants.verdana, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var emailAddressTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.emailAddressPlaceholderText
        textField.font = UIFont.createFont(name: Constants.verdana, size: 18)
        textField.borderStyle = .roundedRect
        textField.delegate = self

        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let imageView = UIImageView(frame: CGRect(x: 6, y: 6, width: 20, height: 18))
        imageView.image = UIImage(named: "envelope")
        leftView.addSubview(imageView)

        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.passwordPlaceholderText
        textField.font = UIFont.createFont(name: Constants.verdana, size: 18)
        textField.borderStyle = .roundedRect
        textField.delegate = self

        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let imageView = UIImageView(frame: CGRect(x: 6, y: 6, width: 20, height: 18))
        imageView.image = UIImage(named: "lock")
        leftView.addSubview(imageView)

        textField.leftView = leftView
        textField.leftViewMode = .always

        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let button = UIButton(frame: CGRect(x: 6, y: 6, width: 20, height: 20))
        button.setImage(.vector, for: .normal)
        rightView.addSubview(button)
        textField.rightView = rightView
        textField.rightViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.loginButtonText, for: .normal)
        button.backgroundColor = .buttonMain
        button.titleLabel?.font = UIFont(name: Constants.verdana, size: 16)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action: #selector(loginButtonTapped(_:)),
            for: .touchUpInside
        )
        return button
    }()

    private let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.errorMessageText
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = .warningLabel
        label.layer.masksToBounds = true
        label.alpha = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 12

        return label
    }()

    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.white.cgColor,
            UIColor.gradientLayer.cgColor,
        ]
        return gradientLayer
    }()

    // MARK: - Public Properties

    var presenter: AuthPresenterProtocol?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupAllConstraints()
        setKeyboard()
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
        view.endEditing(true)
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
        passwordTextField.resignFirstResponder()
        loginButton.setTitle(nil, for: .normal)
        loginButton.setImage(UIImage(systemName: "slowmo"), for: .normal)
        loginButton.tintColor = .white
        UIView.animate(withDuration: 3.0) {
            sender.imageView?.transform = CGAffineTransform(
                rotationAngle: CGFloat.pi
            )
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.presenter?.moveToMain()
        }
    }

    private func setKeyboard() {
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

    // MARK: - Public Methods

    public func upView(_ keyboardHeight: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y -= keyboardHeight
        }
    }

    public func downView(_ keyboardHeight: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y += keyboardHeight
        }
    }
}

// MARK: - AuthViewProtocol

extension AuthViewController: AuthViewProtocol {
    func setPasswordColor(color: String, isValidate: Bool, borderColor: String) {
        passwordLabel.textColor = UIColor(named: color)
        passwordTextField.layer.borderColor = UIColor(named: borderColor)?.cgColor
        wrongPasswordLabel.isHidden = isValidate
    }

    func setLoginColor(color: String, isValidate: Bool, borderColor: String) {
        emailAdressLabel.textColor = UIColor(named: color)
        emailAddressTextField.layer.borderColor = UIColor(named: borderColor)?.cgColor
        incorrectFormatLabel.isHidden = isValidate
    }

    func showEntryErrorMessage() {
        loginButton.setImage(nil, for: .normal)
        loginButton.setTitle("Login", for: .normal)
        UIView.animate(withDuration: 1.0) {
            self.errorMessageLabel.isHidden = false
            self.errorMessageLabel.alpha = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                UIView.animate(withDuration: 1.0) {
                    self.errorMessageLabel.alpha = 0
                }
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension AuthViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter?.checkLogin(login: emailAddressTextField.text)
        presenter?.checkPassword(password: passwordTextField.text)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailAddressTextField:
            passwordTextField.becomeFirstResponder()
        default:
            break
        }
        return true
    }
}
