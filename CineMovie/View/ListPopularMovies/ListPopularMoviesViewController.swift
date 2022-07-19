//
//  ListPopularMoviesViewController.swift
//  CineMovie
//
//  Created by Renan Consalter on 28/06/22.
//

import UIKit

final class ListPopularMoviesViewController: UIViewController {
    
    // MARK: - ViewModel & CollectionView
    var viewModel: ListPopularMoviesViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(PopularMoviesCell.self,
                                forCellWithReuseIdentifier: String(describing: PopularMoviesCell.self))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Lifecycle/Configuration/Setup Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        configureDelegates()
        loadData()
    }
    
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
    }
    
    private func loadData() {
        showSpinner()
        viewModel.loadPopularMovies()
    }
}

// MARK: - UICollectionViewDelegate/DataSource Methods
extension ListPopularMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PopularMoviesCell.self), for: indexPath) as? PopularMoviesCell else { return UICollectionViewCell() }
        
        let movie = viewModel.getMovie(at: indexPath)
        let movieCellViewModel = PopularMoviesCellViewModel(movie: movie)
        
        cell.configure(viewModel: movieCellViewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Methods
extension ListPopularMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // A movie poster has 3:2 dimension, so aspectRatio is 1.5
        let aspectRatio: CGFloat = 3 / 2
        
        let numberOfItemsInRow: CGFloat = 3

        let collectionCellSizeWidth: CGFloat = (view.frame.size.width / numberOfItemsInRow)
        let collectionCellSizeHeight: CGFloat = collectionCellSizeWidth * aspectRatio
        
        return CGSize(
            width: collectionCellSizeWidth,
            height: collectionCellSizeHeight
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - Pagination Methods
extension ListPopularMoviesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = self.collectionView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        let remainingHeightToCallMoreData: CGFloat = 50

        if position > (contentHeight - scrollViewHeight - remainingHeightToCallMoreData) {
            viewModel.loadPopularMovies()
        }
    }
}

// MARK: - ListPopularMoviesViewModelDelegate Methods
extension ListPopularMoviesViewController: ListPopularMoviesViewModelDelegate {
    func didFindPopularMovies() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            self?.hideSpinner()
        }
    }
    
    func didFail(error: ErrorHandler) {
        DispatchQueue.main.async { [weak self] in
            self?.hideSpinner()
            self?.showAlert(message: error.customMessage) { [weak self] _ in
                self?.loadData()
            }
        }
    }
}
