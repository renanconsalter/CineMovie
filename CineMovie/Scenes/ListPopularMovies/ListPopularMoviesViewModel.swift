//
//  ListPopularMoviesViewModel.swift
//  CineMovie
//
//  Created by Renan Consalter on 04/07/22.
//

import Foundation

protocol ListPopularMoviesViewModelDelegate: AnyObject {
    func showPaginationLoading()
    func showLoading()
    func hideLoading()
    func reloadData()
    func didFail(with error: ErrorHandler)
    func setNavigationTitle(to value: String)
}

final class ListPopularMoviesViewModel {
    
    // MARK: Properties
    
    private let service: PopularMoviesServiceProtocol
    
    private var movies: [Movie] = []
    private var currentPage: Int = 1
    private var isLoading: Bool = false
    
    weak var delegate: ListPopularMoviesViewModelDelegate?
    weak var coordinator: ListPopularMoviesCoordinatorProtocol?

    // MARK: Initialization
    
    init(
        service: PopularMoviesServiceProtocol = PopularMoviesService()
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
    
    func didSelectItem(at indexPath: IndexPath) {
        let movie = getMovie(at: indexPath)
        coordinator?.goToMovieDetails(with: movie)
    }
    
    func setNavigationTitle() {
        delegate?.setNavigationTitle(to: Constants.Menus.popular)
    }
    
    func loadPopularMovies() {
        delegate?.showLoading()
        getPopularMovies()
    }
    
    func userRequestMoreData() {
        guard !isLoading else { return }
        delegate?.showPaginationLoading()
        getPopularMovies()
    }
    
    private func getPopularMovies() {
        isLoading = true
        service.getPopularMovies(page: currentPage) { [weak self] result in
            switch result {
            case .success(let popularMovies):
                self?.movies.append(contentsOf: popularMovies.results)
                self?.currentPage = popularMovies.page + 1
                self?.delegate?.reloadData()
            case .failure(let error):
                self?.delegate?.didFail(with: error)
            }
            self?.isLoading = false
            self?.delegate?.hideLoading()
        }
    }
}
