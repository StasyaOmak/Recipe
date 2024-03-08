// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import Photos
import UIKit

/// Протокол-интерфейс вью модуля "Профиль"
protocol ProfileViewControllerProtocol: AnyObject {
    /// метод обновления таблицы
    func reloadTableView()
    /// метод вызова алерта на смену имени
    func showNameEditorAlert()
    /// метод показа экрана политики
    func showTermsScreen()
}

/// Экран данных пользователя
final class ProfileViewController: UIViewController, UINavigationControllerDelegate {
    // MARK: - Constants

    private enum Constants {
        static let navigationTitleText = "Profile"
        static let verdanaBoldFontName = "Verdana-Bold"
        static let headerTableViewCellIdentifier = "HeaderTableViewCell"
        static let optionsTableViewCellIdentifier = "OptionsTableViewCell"
        static let alertTitleText = "Change your name and surname"
        static let alertTextFieldPlaceholder = "Name Surname"
        static let okActionText = "Ok"
        static let cancelActionText = "Cancel"
        static let termsScreenHeight: CGFloat = 750
        static let termsScreenAreaHeight: CGFloat = 20
        static let tabBarHeight: CGFloat = 0
    }

    // MARK: - Visual Components

    private let tableView = UITableView()

    private let profileTitleBarButtonItem: UIBarButtonItem = {
        let label = UILabel()
        label.text = Constants.navigationTitleText
        label.font = UIFont.createFont(name: Constants.verdanaBoldFontName, size: 28)
        let item = UIBarButtonItem(customView: label)
        return item
    }()

    // MARK: - Public Properties

    var presenter: ProfilePresenterProtocol?

    // MARK: - Private Properties

    private var user: User?

    private let optionCells: [Profile] = Profile.sendMock()

    private let tableViewSections: [ProfileFieldType] = [
        .header,
        .common
    ]

    // MARK: - Private Properties

    private var termsView: TermsOfUseView?
    private var visualEffectView: UIVisualEffectView?

    private let termsScreenHeight: CGFloat = Constants.termsScreenHeight
    private let termsScreenAreaHeight: CGFloat = Constants.termsScreenAreaHeight
    private var tabBarHeight: CGFloat = Constants.tabBarHeight

    private var termsViewState: TermsViewState {
        isTermsVisible ? .collapsed : .expanded
    }

    private var isTermsVisible = false

    private var runningAnimations: [UIViewPropertyAnimator] = []
    private var animationProgressWhenInterrupted: CGFloat = 0

    private let termsOfView = TermsOfUseView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = profileTitleBarButtonItem
        setupTableView()
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none

        tableView.register(HeaderTableViewCell.self, forCellReuseIdentifier: Constants.headerTableViewCellIdentifier)
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: Constants.optionsTableViewCellIdentifier)

        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self

        setTableViewConstraints()
    }

    private func setTableViewConstraints() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    @objc private func changePhotoAction() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let chooseFromGalleryAction = UIAlertAction(title: "Выбрать из галереи", style: .default) { _ in
            self.showImagePicker(sourceType: .photoLibrary)
        }
        actionSheet.addAction(chooseFromGalleryAction)

        let takePhotoAction = UIAlertAction(title: "Сделать фото", style: .default) { _ in
            self.showImagePicker(sourceType: .camera)
        }
        actionSheet.addAction(takePhotoAction)

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true, completion: nil)
    }

    private func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
}

/// Расширение вью методами протокола-интерфейса ProfileViewControllerProtocol
extension ProfileViewController: ProfileViewControllerProtocol {
    func showTermsScreen() {
        configureTermsView()
    }

    func reloadTableView() {
        tableView.reloadData()
    }

    func showNameEditorAlert() {
        let alert = UIAlertController(title: Constants.alertTitleText, message: nil, preferredStyle: .alert)

        alert.addTextField()
        alert.textFields?.first?.placeholder = Constants.alertTextFieldPlaceholder

        let okAction = UIAlertAction(title: Constants.okActionText, style: .default) { [weak self] _ in
            guard let text = alert.textFields?.first?.text else { return }
            self?.presenter?.changeUserName(name: text)
        }

        let cancelAction = UIAlertAction(title: Constants.cancelActionText, style: .cancel)

        alert.addAction(okAction)
        alert.addAction(cancelAction)
        alert.preferredAction = okAction

        present(alert, animated: true)
    }

    func showLogOutAlert() {
        let alert = UIAlertController(
            title: "Вы точно хотите выйти?",
            message: "Подтвердите действие",
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(title: Constants.okActionText, style: .default) { [weak self] _ in
            self?.presenter?.logOut()
            self?.tableView.reloadData()
        }

        let cancelAction = UIAlertAction(title: Constants.cancelActionText, style: .cancel)

        alert.addAction(okAction)
        alert.addAction(cancelAction)
        alert.preferredAction = okAction

        present(alert, animated: true)
    }

    func saveImageToDocumentDirectory(_ chosenImage: UIImage) -> String {
        let directoryPath = NSHomeDirectory().appending("/Documents/")
        if !FileManager.default.fileExists(atPath: directoryPath) {
            do {
                try FileManager.default.createDirectory(
                    at: NSURL.fileURL(withPath: directoryPath),
                    withIntermediateDirectories: true,
                    attributes: nil
                )
            } catch {
                print(error)
            }
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddhhmmss"

        let filename = dateFormatter.string(from: Date()).appending(".jpg")
        let filepath = directoryPath.appending(filename)
        let url = NSURL.fileURL(withPath: filepath)
        do {
            try chosenImage.jpegData(compressionQuality: 1.0)?.write(to: url, options: .atomic)
            return String("/Documents/\(filename)")

        } catch {
            print(error)
            print("file cant not be save at path \(filepath), with error : \(error)")
            return filepath
        }
    }
}

// MARK: - ProfileViewController + UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        tableViewSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableViewSections[section] {
        case .header:
            return 1
        case .common:
            return optionCells.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableViewSections[indexPath.section] {
        case .header:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: Constants.headerTableViewCellIdentifier,
                    for: indexPath
                ) as? HeaderTableViewCell
            else { return UITableViewCell() }
            let user = UserSettings.shared.getUserSettings()
            cell.configure(user: user)
            cell.editNameHandler = { [weak self] in
                self?.presenter?.editButtonTapped()
            }
            cell.changePhotoHandler = { [weak self] in
                self?.changePhotoAction()
            }
            return cell
        case .common:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: Constants.optionsTableViewCellIdentifier,
                    for: indexPath
                ) as? OptionsTableViewCell
            else { return UITableViewCell() }
            cell.configure(option: optionCells[indexPath.row])
            return cell
        }
    }
}

// MARK: - ProfileViewController + UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableViewSections[indexPath.section] {
        case .header:
            break
        case .common:
            switch optionCells[indexPath.row].type {
            case .bonuses:
                presenter?.bonusesCellTapped()
            case .terms:
                presenter?.termsOfUseCellTapped()
            case .logOut:
                showLogOutAlert()
            }
        }
    }
}

// MARK: - UIImagePickerControllerDelegate

extension ProfileViewController: UIImagePickerControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        if let selectedImage = info[.originalImage] as? UIImage {
            guard let imageData = selectedImage.pngData() else { return }
            UserSettings.shared.changeUserImage(imageData: imageData)
            tableView.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - ProfileViewController

extension ProfileViewController {
    enum TermsViewState {
        case expanded
        case collapsed
    }

    private func configureTermsView() {
        termsOfView.frame = CGRect(
            x: 0,
            y: view.bounds.height / 2,
            width: view.bounds.width,
            height: view.bounds.height
        )

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleTermsViewPan))

        termsOfView.setGesture(gestures: [panGestureRecognizer])
        let scene = UIApplication.shared.connectedScenes
        let windowScene = scene.first as? UIWindowScene

        UIView.animate(withDuration: 2) {
            windowScene?.windows.last?.addSubview(self.termsOfView)
        }
    }

    func animateTransitionOfNeeded(state: TermsViewState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateFrame(state: state, duration: duration)
            animateCornerRadius(state: state, duration: duration)
            animateBlur(state: state, duration: duration)
        }
    }

    func animateFrame(state: TermsViewState, duration: TimeInterval) {
        let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
            switch state {
            case .expanded:
                self.termsOfView.frame.origin.y = self.view.frame.height - self.termsScreenHeight + self.tabBarHeight
            case .collapsed:
                self.termsOfView.frame.origin.y = self.view.frame.height - self.termsScreenAreaHeight
            }
        }

        frameAnimator.addCompletion { _ in
            self.isTermsVisible = !self.isTermsVisible
            self.runningAnimations.removeAll()
        }

        frameAnimator.startAnimation()
        runningAnimations.append(frameAnimator)
    }

    func animateCornerRadius(state: TermsViewState, duration: TimeInterval) {
        let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
            switch state {
            case .expanded:
                self.termsOfView.layer.cornerRadius = 12
            case .collapsed:
                self.termsOfView.layer.cornerRadius = 0
            }
        }

        cornerRadiusAnimator.startAnimation()
        runningAnimations.append(cornerRadiusAnimator)
    }

    func animateBlur(state: TermsViewState, duration: TimeInterval) {
        let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
            self.visualEffectView?.effect = UIBlurEffect(style: .dark)
        }

        blurAnimator.startAnimation()
        runningAnimations.append(blurAnimator)
    }

    func startInteractive(state: TermsViewState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionOfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }

    func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }

    func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }

    @objc func handleTermsViewPan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractive(state: termsViewState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: termsOfView.handleAreaView)
            var fractionComplete = translation.y / termsScreenHeight
            fractionComplete = isTermsVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
}
