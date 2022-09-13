//
//  ListPopularMoviesViewController.swift
//  CineMovie
//
//  Created by Renan Consalter on 28/06/22.
//

import UIKit

final class ListPopularMoviesViewController: UIViewController {
    
    // MARK: Properties
    
    private let viewModel: ListPopularMoviesViewModel
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.register(
            PopularMoviesCell.self,
            forCellWithReuseIdentifier: String(describing: PopularMoviesCell.self)
        )
        collectionView.register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: Constants.Identifiers.popularMoviesCollectionViewFooterIdentifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let collectionViewFooter: UICollectionReusableView = {
        let view = UICollectionReusableView()
        return view
    }()
    
    // MARK: Initialization
    
    init(viewModel: ListPopularMoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        configureDelegates()
        configureTitle()
        loadData()
    }
    
    // MARK: Configuration/Setup
    
    private func configureViews() {
        view.addSubview(collectionView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configureDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.delegate = self
    }
    
    private func configureTitle() {
        viewModel.setNavigationTitle()
    }
    
    // MARK: Data Manipulation Methods
    
    private func loadData() {
        viewModel.loadPopularMovies()
    }
}

// MARK: UICollectionViewDelegate/DataSource Methods

extension ListPopularMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: PopularMoviesCell.self),
            for: indexPath
        ) as? PopularMoviesCell
        else { return UICollectionViewCell() }
        
        let movie = viewModel.getMovie(at: indexPath)
        let movieCellViewModel = PopularMoviesCellViewModel(movie: movie)
        
        cell.setup(with: movieCellViewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastSection = collectionView.numberOfSections - 1
        let lastItem = collectionView.numberOfItems(inSection: lastSection) - 1
        if indexPath.section == lastSection && indexPath.row == lastItem {
            viewModel.userRequestMoreData()
        }
    }
}

// MARK: UICollectionFooter Methods

extension ListPopularMoviesViewController {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionFooter,
                withReuseIdentifier: String(describing: Constants.Identifiers.popularMoviesCollectionViewFooterIdentifier),
                for: indexPath
            )
            collectionViewFooter.frame = CGRect(x: 0, y: 0, width: footer.frame.size.width, height: 100)
            footer.addSubview(collectionViewFooter)
            return footer
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: view.frame.size.width, height: 100)
    }
}

// MARK: UICollectionViewDelegateFlowLayout Methods

extension ListPopularMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // A movie poster has 3:2 dimension, so aspect ratio is 1.5
        let aspectRatio: CGFloat = 3 / 2
        
        let numberOfItemsInRow: CGFloat = 3

        let collectionViewCellSizeWidth: CGFloat = (view.frame.size.width / numberOfItemsInRow)
        let collectionViewCellSizeHeight: CGFloat = collectionViewCellSizeWidth * aspectRatio
        
        return CGSize(
            width: collectionViewCellSizeWidth,
            height: collectionViewCellSizeHeight
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: ListPopularMoviesViewModelDelegate Methods

extension ListPopularMoviesViewController: ListPopularMoviesViewModelDelegate, Loadable, Alertable {
    func showLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.showSpinner(on: self.view)
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.removeSpinner(on: self.view)
            self.removeSpinner(on: self.collectionViewFooter)
        }
    }
    
    func showPaginationLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.showSpinner(on: self.collectionViewFooter, size: .medium)
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func didFail(with error: ErrorHandler) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.showActionAlert(
                message: error.customMessage,
                action: self.loadData
            )
        }
    }
    
    func setNavigationTitle(to value: String) {
        DispatchQueue.main.async { [weak self] in
            self?.title = value
        }
    }
}
