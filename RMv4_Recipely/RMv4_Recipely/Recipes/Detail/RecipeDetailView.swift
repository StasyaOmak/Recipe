// RecipeDetailView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол экрана деталей рецептов
protocol RecipeDetailViewProtocol: AnyObject {
    /// Презентер экрана
    var presenter: RecipeDetailPresenterProtocol? { get set }
    /// метод смены цвета кнопки "добавить в избранное"
    func setRedAddToFavoritesButtonColor()
    /// метод смены цвета кнопки "добавить в избранное"
    func setBlackAddToFavoritesButtonColor()
    /// обновление состояния вью
    func updateState()
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
    enum CellType: CaseIterable {
        // Ячейка с картинкой и заголовком
        case title
        // Ячейка с БЖУ
        case characteristics
        // Ячейка с полным описанием рецепта
        case fullDescription
    }

    // MARK: - Public Properties

    private let sectionCell: [CellType] = [.title, .characteristics, .fullDescription]

    // MARK: - Visual Components

    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshControlPulled(_:)), for: .valueChanged)
        return control
    }()

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

    private lazy var shareBarButtonItem: UIBarButtonItem = .init(
        image: UIImage(systemName: "paperplane"),
        style: .plain,
        target: self,
        action: #selector(shareBarButtonItemTapped)
    )

    private lazy var addToFavouritesBarButtonItem: UIBarButtonItem = .init(
        image: UIImage.favBookmarkPlain,
        style: .plain,
        target: self,
        action: #selector(addToFavouritesBarButtonItemTapped)
    )

    private let tableView = UITableView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        setupNavigationBar()
        configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getRecipeDescription()
        addLogs()
    }

    // MARK: - Private Methods

    private func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshControl
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: Constants.titleTableViewCellIdentifier)
        tableView.register(
            CharacteristicsTableViewCell.self,
            forCellReuseIdentifier: Constants.characteristicsTableViewCellIdentifier
        )
        tableView.register(
            FullDescriptionTableViewCell.self,
            forCellReuseIdentifier: Constants.fullDescriptionTableViewCellIdentifier
        )
        tableView.register(
            EmptyResultTableViewCell.self,
            forCellReuseIdentifier: EmptyResultTableViewCell.description()
        )

        tableView.register(
            ErrorTableViewCell.self,
            forCellReuseIdentifier: ErrorTableViewCell.description()
        )

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItems = [addToFavouritesBarButtonItem, shareBarButtonItem]
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: arrowButton)]
        addToFavouritesBarButtonItem.tintColor = .black
        shareBarButtonItem.tintColor = .black
        addToFavouritesBarButtonItem.isEnabled = true
        shareBarButtonItem.isEnabled = true
    }

    private func addLogs() {
        presenter?.sendLog(message: .openDetailsRecipe)
    }

    @objc private func shareBarButtonItemTapped() {}

    @objc private func addToFavouritesBarButtonItemTapped() {
        switch presenter?.state {
        case let .data(recipe):
            presenter?.addToFavorites(fullRecipe: recipe)
        default:
            break
        }
    }

    @objc private func backButtonTapped() {
        presenter?.popToAllRecipes()
    }

    @objc private func refreshControlPulled(_ sender: UIRefreshControl) {
        presenter?.getRecipeDescription()
        updateState()
        sender.endRefreshing()
    }
}

extension RecipeDetailView: RecipeDetailViewProtocol {
    func setRedAddToFavoritesButtonColor() {
        addToFavouritesBarButtonItem.image = UIImage.bookmarkRedFilled.withRenderingMode(.alwaysOriginal)
        view.layoutIfNeeded()
    }

    func setBlackAddToFavoritesButtonColor() {
        addToFavouritesBarButtonItem.image = UIImage.favBookmarkPlain
        view.layoutIfNeeded()
    }

    func updateState() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - RecipeDetailView + UITableViewDataSource

extension RecipeDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch presenter?.state {
        case .loading:
            CellType.allCases.count
        case .data:
            CellType.allCases.count
        case .noData:
            1
        case .error:
            1
        case nil:
            1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch presenter?.state {
        case let .data(recipe):
            let item = sectionCell[indexPath.row]
            switch item {
            case .title:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: Constants.titleTableViewCellIdentifier,
                    for: indexPath
                ) as? TitleTableViewCell
                else { return UITableViewCell() }
                presenter?.loadImage(url: URL(string: recipe.imageName ?? ""), completion: { data in
                    cell.setImage(data: data)
                })
                cell.configure(recipe: recipe)
                return cell

            case .characteristics:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: Constants.characteristicsTableViewCellIdentifier,
                    for: indexPath
                ) as? CharacteristicsTableViewCell
                else { return UITableViewCell() }
                cell.configure(recipe: recipe)
                return cell

            case .fullDescription:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: Constants.fullDescriptionTableViewCellIdentifier,
                    for: indexPath
                ) as? FullDescriptionTableViewCell
                else { return UITableViewCell() }
                cell.configure(recipe: recipe)
                return cell
            }
        case .loading:
            let item = sectionCell[indexPath.row]
            switch item {
            case .title:
                let cell = SkeletonTableViewCell()
                cell.contentView.heightAnchor.constraint(equalToConstant: 350).isActive = true
                return cell
            case .characteristics:
                let cell = SkeletonTableViewCell()
                cell.contentView.heightAnchor.constraint(equalToConstant: 90).isActive = true
                return cell
            case .fullDescription:
                let cell = SkeletonTableViewCell()
                cell.contentView.heightAnchor.constraint(equalToConstant: 500).isActive = true
                return cell
            }
        case .noData:
            let cell = EmptyResultTableViewCell()
            return cell
        case .error, .none:
            let cell = ErrorTableViewCell()
            cell.reloadButtonHandler = { [weak self] in
                self?.presenter?.getRecipeDescription()
                tableView.reloadData()
            }
            return cell
        }
    }
}

extension RecipeDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch presenter?.state {
        case .error:
            return tableView.frame.height
        case .noData:
            return tableView.frame.height
        default:
            return tableView.estimatedRowHeight
        }
    }
}
