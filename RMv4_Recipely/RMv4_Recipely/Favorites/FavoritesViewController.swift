// FavoritesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс вью модуля "избранные рецепты"
protocol FavoritesViewControllerProtocol: AnyObject {
    /// метод установки вью в состояние - нет избранных рецептов
    func setEmptyState()
    /// метод установки вью в сщстояние - есть избранные рецепты
    func setNonEmptyState()
}

/// Экран отображения избранных рецептов
final class FavoritesViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let navigationTitleText = "Favorites"
        static let verdanaBoldFontName = "Verdana-Bold"
        static let verdanaFontName = "Verdana"
        static let emptyLabelText = "There's nothing here yet"
        static let additionalEmptyLabelText = "Add interesting recipes to make ordering products convenient"
    }

    // MARK: - Visual Components

    private let profileTitleBarButtonItem: UIBarButtonItem = {
        let label = UILabel()
        label.text = Constants.navigationTitleText
        label.font = UIFont(name: Constants.verdanaBoldFontName, size: 28)
        let item = UIBarButtonItem(customView: label)
        return item
    }()

    private let emptyMessageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let iconView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.backgroundColor = .lightBlueBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bookmark
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .basicGreen
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.emptyLabelText
        label.font = UIFont(name: Constants.verdanaBoldFontName, size: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let additionalEmptyLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.additionalEmptyLabelText
        label.font = UIFont(name: Constants.verdanaFontName, size: 14)
        label.textColor = .lightGray
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
//        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: RecipeTableViewCell.description())
        return tableView
    }()

    // MARK: - Public Properties

    var presenter: FavoritesPresenterProtocol?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        presenter?.checkIfFavouritesEmpty()
        tableView.reloadData()
    }

    // MARK: - Private Methods

    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = profileTitleBarButtonItem

        view.addSubview(emptyMessageView)

        emptyMessageView.addSubview(iconView)
        emptyMessageView.addSubview(iconImageView)
        emptyMessageView.addSubview(emptyLabel)
        emptyMessageView.addSubview(additionalEmptyLabel)

        view.addSubview(tableView)

        setConstraints()
    }

    private func setConstraints() {
        setEmptyMessageViewConstraints()
        setIconViewConstraints()
        setIconImageViewConstraints()
        setEmptyLabelConstraints()
        setAdditionalEmptyLabelConstraints()
        setTableViewConstraints()
    }

    private func setEmptyMessageViewConstraints() {
        emptyMessageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
            .isActive = true
        emptyMessageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        emptyMessageView.heightAnchor.constraint(equalToConstant: 132).isActive = true
        emptyMessageView.widthAnchor.constraint(equalToConstant: 350).isActive = true
    }

    private func setIconViewConstraints() {
        iconView.centerXAnchor.constraint(equalTo: emptyMessageView.centerXAnchor).isActive = true
        iconView.topAnchor.constraint(equalTo: emptyMessageView.topAnchor).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor).isActive = true
    }

    private func setIconImageViewConstraints() {
        iconImageView.centerYAnchor.constraint(equalTo: iconView.centerYAnchor).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: iconView.centerXAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 14).isActive = true
    }

    private func setEmptyLabelConstraints() {
        emptyLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 16).isActive = true
        emptyLabel.centerXAnchor.constraint(equalTo: emptyMessageView.centerXAnchor).isActive = true
    }

    private func setAdditionalEmptyLabelConstraints() {
        additionalEmptyLabel.topAnchor.constraint(equalTo: emptyLabel.bottomAnchor, constant: 8).isActive = true
        additionalEmptyLabel.leadingAnchor.constraint(equalTo: emptyMessageView.leadingAnchor, constant: 16)
            .isActive = true
        additionalEmptyLabel.trailingAnchor.constraint(equalTo: emptyMessageView.trailingAnchor, constant: -16)
            .isActive = true
    }

    private func setTableViewConstraints() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

// MARK: - FavoritesViewControllerProtocol

extension FavoritesViewController: FavoritesViewControllerProtocol {
    func setEmptyState() {
        tableView.isHidden = true
    }

    func setNonEmptyState() {
        tableView.isHidden = false
    }
}

// MARK: - UITableViewDataSource

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getFavouritesCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: RecipeTableViewCell.description()) as? RecipeTableViewCell,
            let recipes = presenter?.getFavourites() else { return UITableViewCell() }
        cell.configure(recipe: recipes[indexPath.row])
        cell.backgroundView?.backgroundColor = .basicGreen
        return cell
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        presenter?.removeFromFavourites(recipeIndex: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        presenter?.checkIfFavouritesEmpty()
    }
}
