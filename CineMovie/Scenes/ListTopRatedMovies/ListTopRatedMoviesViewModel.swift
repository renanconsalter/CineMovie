//
//  ListTopRatedMoviesViewModel.swift
//  CineMovie
//
//  Created by Renan Consalter on 30/06/22.
//

import Foundation

protocol ListTopRatedMoviesViewModelDelegate: AnyObject {
    func showPaginationLoading()
    func showLoading()
    func hideLoading()
    func reloadData()
    func didFail(with error: ErrorHandler)
    func setNavigationTitle(to value: String)
}

final class ListTopRatedMoviesViewModel {
    
    // MARK: Properties
    
    private let service: TopRatedMoviesServiceProtocol
    
    private var movies: [Movie] = []
    private var currentPage: Int = 1
    private var isLoading: Bool = false
    
    weak var delegate: ListTopRatedMoviesViewModelDelegate?
    weak var coordinator: ListTopRatedMoviesCoordinatorProtocol?
    
    // MARK: Initialization
    
    init(
        service: TopRatedMoviesServiceProtocol = TopRatedMoviesService()
    ) {
        self.service = service
    }
    
    // MARK: Methods
    
    func getMovie(at indexPath: IndexPath) -> Movie {
        return movies[indexPath.row]
    }
    
    func numberOfRows() -> Int {
        return movies.count
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let movie = getMovie(at: indexPath)
        coordinator?.goToMovieDetails(with: movie)
    }
    
    func setNavigationTitle() {
        delegate?.setNavigationTitle(to: Constants.Menus.topRated)
    }
    
    func loadTopRatedMovies() {
        delegate?.showLoading()
        getTopRatedMovies()
    }
    
    func userRequestMoreData() {
        guard !isLoading else { return }
        delegate?.showPaginationLoading()
        getTopRatedMovies()
    }
    
    private func getTopRatedMovies() {
        isLoading = true
        service.getTopRatedMovies(page: currentPage) { [weak self] result in
            switch result {
            case .success(let topRatedMovies):
                self?.movies.append(contentsOf: topRatedMovies.results)
                self?.currentPage = topRatedMovies.page + 1
                self?.delegate?.reloadData()
            case .failure(let error):
                self?.delegate?.didFail(with: error)
            }
            self?.isLoading = false
            self?.delegate?.hideLoading()
        }
    }
}
