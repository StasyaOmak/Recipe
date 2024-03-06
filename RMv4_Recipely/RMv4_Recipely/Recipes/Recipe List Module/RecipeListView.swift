// RecipeListView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерфейс вью модуля "Рецепты выбранной категории"
protocol RecipeListViewControllerProtocol: AnyObject {
    /// свойство-презентер
    var presenter: RecipeListPresenterProtocol? { get set }
    /// метод установки категории рецептов
    func setRecipes(_ recipes: [RecipeDescription])
    /// метод установки заголовка для страницы
    func setTitle(_ title: String)
    /// Метод снятия выделения со всех кнопок фильтров
    func disableAllFilterButtons()
    /// метод проверки состояния второго фильтра
    func checkAnotherFilter(sender: FilterButton) -> (isPressed: Bool, increasing: Bool, decreasing: Bool)
    /// метод перехода к следующему состоянию экрана
    func nextState()
    /// метод обновления таблицы
    func reloadTableView()

}

/// Экран с рецептами для выбранной категории
final class RecipeListViewController: UIViewController {
    enum State {
        case loading
        case success
    }

//    var data = [RecipeDescription]
//    var searching = true


    // MARK: - Constants

    private enum Constants {
        static let verdanaFontName = "Verdana-Bold"
        static let searchBarPlaceholder = "Search recipes"
        static let caloriesButtonTitle = "Calories"
        static let timeButtonTitle = "Time"
        static let recipeTableViewCellIdentifier = "RecipeTableViewCell"
    }

    // MARK: - Visual Components

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

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.verdanaFontName, size: 28)
        label.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        label.addGestureRecognizer(tapRecognizer)
        return label
    }()

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.layer.cornerRadius = 8
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        searchBar.searchTextField.backgroundColor = .lightGreenBackground
        searchBar.placeholder = Constants.searchBarPlaceholder
        return searchBar
    }()

    private let filtersScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: 500, height: 60)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isUserInteractionEnabled = true
        return scrollView
    }()

    private let caloriesFilterButton: FilterButton = {
        let button = FilterButton()
        button.title.text = Constants.caloriesButtonTitle
        return button
    }()

    private let timeFilterButton: FilterButton = {
        let button = FilterButton()
        button.title.text = Constants.timeButtonTitle
        return button
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: RecipeTableViewCell.description())
        tableView.register(SkeletonTableViewCell.self, forCellReuseIdentifier: SkeletonTableViewCell.description())
        return tableView
    }()

    // MARK: - Public Properties

    var presenter: RecipeListPresenterProtocol?

    // MARK: - Private Properties

    private var recipes: [RecipeDescription]?
    private lazy var buttons: [FilterButton] = [caloriesFilterButton, timeFilterButton]

    var state: State = .loading
    private var isLoaded: Bool {
        switch state {
        case .loading:
            return false
        case .success:
            return true
        }
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(filtersScrollView)
        view.addSubview(tableView)
        setupConstraints()
        setupFilterButtons()

        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(customView: arrowButton),
            UIBarButtonItem(customView: titleLabel)
        ]

        presenter?.changeState()
    }

    private func setupConstraints() {
        setupSearchBarConstraints()
        setupScrollViewConstraints()
        setupTableViewConstraints()
    }

    private func setupSearchBarConstraints() {
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
            .isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setupScrollViewConstraints() {
        filtersScrollView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 4).isActive = true
        filtersScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4)
            .isActive = true
        filtersScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4)
            .isActive = true
        filtersScrollView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }

    private func setupFilterButtons() {
        for (index, button) in buttons.enumerated() {
            filtersScrollView.addSubview(button)
            button.tag = index
            button.centerYAnchor.constraint(equalTo: filtersScrollView.centerYAnchor).isActive = true
            button.leadingAnchor.constraint(
                equalTo: filtersScrollView.leadingAnchor,
                constant: 130 * CGFloat(index) + 10
            ).isActive = true

            if index == 0 {
                button.trailingAnchor.constraint(equalTo: filtersScrollView.trailingAnchor, constant: -4)
                    .isActive = true
            }

            button.addTarget(self, action: #selector(filterButtonTapped(sender:)), for: .touchUpInside)
        }
    }

    private func setupTableViewConstraints() {
        tableView.topAnchor.constraint(equalTo: filtersScrollView.bottomAnchor, constant: 4).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4)
            .isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none

        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: Constants.recipeTableViewCellIdentifier)
    }

    @objc private func backButtonTapped() {
        presenter?.popToAllRecipes()
    }

    @objc private func filterButtonTapped(sender: FilterButton) {
        presenter?.filterButtonPressed(sender: sender)
    }
}

// MARK: - RecipeListViewController + RecipeListViewControllerProtocol

extension RecipeListViewController: RecipeListViewControllerProtocol {
    func reloadTableView() {
        tableView.reloadData()
    }

    func setRecipes(_ recipes: [RecipeDescription]) {
        self.recipes = recipes
        tableView.reloadData()
    }

    func setTitle(_ title: String) {
        titleLabel.text = title
    }

    func disableAllFilterButtons() {
        buttons.forEach { $0.isPressed = false }
    }

    func nextState() {
        state = .success
        tableView.reloadData()
    }

    func checkAnotherFilter(sender: FilterButton) -> (isPressed: Bool, increasing: Bool, decreasing: Bool) {
        switch sender {
        case caloriesFilterButton:
            return (timeFilterButton.isPressed, timeFilterButton.isInIncreaseOrder, timeFilterButton.isInDecreaseOrder)
        case timeFilterButton:
            return (
                caloriesFilterButton.isPressed,
                caloriesFilterButton.isInIncreaseOrder,
                caloriesFilterButton.isInDecreaseOrder
            )
        default:
            return (false, true, false)
        }
    }
}

// MARK: - RecipeListViewController: UITableViewDataSource

extension RecipeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let searchRecipes = presenter?.checkSearch() else { return 0 }
        return searchRecipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let regularCell = tableView
            .dequeueReusableCell(
                withIdentifier: RecipeTableViewCell.description(),
                for: indexPath
            ) as? RecipeTableViewCell,
            let searchRecipes = presenter?.checkSearch()
        else { return UITableViewCell() }
        regularCell.configure(recipe: recipes[indexPath.row])
        guard let skeletonCell = tableView
            .dequeueReusableCell(
                withIdentifier: SkeletonTableViewCell.description(),
                for: indexPath
            ) as? SkeletonTableViewCell
        else { return UITableViewCell() }
        let cell = isLoaded ? regularCell : skeletonCell

        return cell
    }
}

// MARK: - RecipeListViewController: UITableViewDelegate

extension RecipeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.isSelected = !cell.isSelected
        guard let recipes = recipes else { return }
        presenter?.pushToDetail(recipe: recipes[indexPath.row])
    }

    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let cell = tableView.cellForRow(at: indexPath) else { return indexPath }
        cell.isSelected = false
        return indexPath
    }
}

// MARK: - RecipeListViewController: UISearchBarDelegate

extension RecipeListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 3 {
            presenter?.searchRecipes(withText: searchText)
        } else {
            presenter?.searchRecipes(withText: "")
        }
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        presenter?.startSearch()
        tableView.reloadData()
    }
}
