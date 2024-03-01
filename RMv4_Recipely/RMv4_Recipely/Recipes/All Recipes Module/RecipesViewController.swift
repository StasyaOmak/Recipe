// RecipesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол экрана рецептов
protocol RecipesViewControllerProtocol: AnyObject {
    var recipesPresenter: RecipesPresenterProtocol? { get set }
}

/// Экран для отображения меню выбора рецептов
final class RecipesViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let navigationTitleText = "Recipes"
        static let verdanaBold = "Verdana-Bold"
    }

    // MARK: - Public Properties

    weak var collectionView: UICollectionView!
    var recipesPresenter: RecipesPresenterProtocol?

    // MARK: - Life Cycle

    override func loadView() {
        super.loadView()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        navigationItem.leftBarButtonItem = recipesTitleBarButtonItem

        self.collectionView = collectionView

        setupViews()
        setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RecipesCustomCell.self, forCellWithReuseIdentifier: "cell")
    }

    // MARK: - Private Properties

    private let recipesTitleBarButtonItem: UIBarButtonItem = {
        let label = UILabel()
        label.text = Constants.navigationTitleText
        label.font = UIFont(name: Constants.verdanaBold, size: 28)
        let item = UIBarButtonItem(customView: label)
        return item
    }()

    private func setupConstraints() {
        setupCollectionViewConstraints()
    }

    private func setupViews() {
        view.addSubview(collectionView)
    }

    private func setupCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

// MARK: - RecipesViewController + UICollectionViewDelegate

extension RecipesViewController: UICollectionViewDelegate {}

// MARK: - RecipesViewController + RecipesViewControllerProtocol

extension RecipesViewController: RecipesViewControllerProtocol {}

// MARK: - RecipesViewController + UICollectionViewDataSource

extension RecipesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recipesPresenter?.getCategoryCount() ?? 0
    }

    // создание и настройка ячейки
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let category = recipesPresenter?.getInfo(categoryNumber: indexPath.item)
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? RecipesCustomCell
        else { return UICollectionViewCell() }
        cell.setInfo(info: category ?? DishCategory(imageName: "", type: .chicken))
        return cell
    }
}

// MARK: - RecipesViewController + UICollectionViewDelegateFlowLayout

extension RecipesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        var cellSize = CGFloat()
        let cellNumber = indexPath.item % 7

        switch cellNumber {
        case 0, 1:
            cellSize = (view.frame.width - 30) / 2
        case 2, 6:
            cellSize = view.frame.width - 140
        case 3 ... 5:
            cellSize = (view.frame.width - 40) / 3
        default:
            cellSize = 10
        }
        return CGSize(width: cellSize, height: cellSize)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        10
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        9
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        recipesPresenter?.goToCategory(.chicken)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
