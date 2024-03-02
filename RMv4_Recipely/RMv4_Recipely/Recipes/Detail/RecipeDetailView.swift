// RecipeDetailView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол экрана деталей рецептов
protocol RecipeDetailViewProtocol: AnyObject {
    /// Презентер экрана
    var presenter: RecipeDetailPresenterProtocol? { get set }
}

/// Экран деталей рецепта
final class RecipeDetailView: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let titleTableViewCellIdentifier = "TitleTableViewCell"
        static let characteristicsTableViewCellIdentifier = "CharacteristicsTableViewCell"
        static let fullDescriptionTableViewCellIdentifier = "FullDescriptionTableViewCell"
    }

    var presenter: RecipeDetailPresenterProtocol?

    /// Виды ячеек
    enum CellType {
        // Ячейка с картинкой и заголовком
        case title
        // Ячейка с БЖУ
        case characteristics
        // Ячейка с полным описанием рецепта
        case fullDescription
    }

    // MARK: - Public Properties

    private let sectionCell: [CellType] = [.title, .characteristics, .fullDescription]

    private let tableView = UITableView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        setupNavigationBar()
        configureTableView()
    }

    // MARK: - Private Methods

    private func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: Constants.titleTableViewCellIdentifier)
        tableView.register(
            CharacteristicsTableViewCell.self,
            forCellReuseIdentifier: Constants.characteristicsTableViewCellIdentifier
        )
        tableView.register(
            FullDescriptionTableViewCell.self,
            forCellReuseIdentifier: Constants.fullDescriptionTableViewCellIdentifier
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItems = [addBarButtonItem, actionBarButtonItem]
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: arrowButton)]
        actionBarButtonItem.tintColor = .black
        addBarButtonItem.tintColor = .black

        actionBarButtonItem.isEnabled = true
        addBarButtonItem.isEnabled = true
    }

    private lazy var arrowButton: UIButton = {
        let view = UIView()
        let button = UIButton()
        button.setImage(UIImage.arrow, for: .normal)
        button.addTarget(
            self,
            action: #selector(backButtonTapped),
            for: .touchUpInside
        )
        return button
    }()

    private lazy var addBarButtonItem: UIBarButtonItem = .init(
        image: UIImage(systemName: "paperplane"),
        style: .plain,
        target: self,
        action: #selector(addBarButtonTapped)
    )

    private lazy var actionBarButtonItem: UIBarButtonItem = .init(
        image: UIImage(systemName: "bookmark"),
        style: .plain,
        target: self,
        action: #selector(actionBarButtonTapped)
    )

    @objc private func addBarButtonTapped() {}

    @objc private func actionBarButtonTapped() {
        print("You can share an image")
    }

    @objc private func backButtonTapped() {
        presenter?.popToAllRecipes()
    }
}

extension RecipeDetailView: RecipeDetailViewProtocol {}

// MARK: - RecipeDetailView + UITableViewDataSource

extension RecipeDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionCell.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sectionCell[indexPath.row]
        switch item {
        case .title:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.titleTableViewCellIdentifier,
                for: indexPath
            ) as? TitleTableViewCell
            else { return UITableViewCell() }
            cell.configure(recipe: presenter?.recipe)
            return cell

        case .characteristics:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.characteristicsTableViewCellIdentifier,
                for: indexPath
            ) as? CharacteristicsTableViewCell
            else { return UITableViewCell() }
            cell.configure(recipe: presenter?.recipe)
            return cell

        case .fullDescription:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.fullDescriptionTableViewCellIdentifier,
                for: indexPath
            ) as? FullDescriptionTableViewCell
            else { return UITableViewCell() }
            cell.configure(recipe: presenter?.recipe)
            return cell
        }
    }
}
