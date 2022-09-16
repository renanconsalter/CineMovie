//
//  SearchMoviesViewModel.swift
//  CineMovie
//
//  Created by Renan Consalter on 04/07/22.
//

import Foundation

protocol SearchMoviesViewModelDelegate: AnyObject {
    func showTableViewHeaderLoading()
    func hideLoading()
    func showEmptyState()
    func showNoResultsState()
    func reloadData()
    func didFail(with error: ErrorHandler)
    func setNavigationTitle(to value: String)
}

final class SearchMoviesViewModel {
    
    // MARK: Properties

    private let service: SearchMoviesServiceProtocol
    
    private var movies: [Movie] = []
    
    weak var delegate: SearchMoviesViewModelDelegate?
    weak var coordinator: SearchMoviesCoordinatorProtocol?
    
    // MARK: Initialization
    
    init(
        service: SearchMoviesServiceProtocol = SearchMoviesService()
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
    
    func setNavigationTitle() {
        delegate?.setNavigationTitle(to: Constants.Menus.search)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let movie = getMovie(at: indexPath)
        coordinator?.goToMovieDetails(with: movie)
    }
    
    func searchMovies(with query: String) {
        let characterCount = query.count
        
        switch characterCount {
        case 0:
            self.movies = []
            self.delegate?.showEmptyState()
            self.delegate?.hideLoading()
        default:
            self.delegate?.showTableViewHeaderLoading()
            service.searchMovie(query: query) { [weak self] result in
                switch result {
                case .success(let movies):
                    self?.movies = movies.results
                    let noResults = movies.results.isEmpty
                    if noResults {
                        self?.delegate?.showNoResultsState()
                    } else {
                        self?.delegate?.reloadData()
                    }
                case .failure(let error):
                    self?.delegate?.didFail(with: error)
                }
                self?.delegate?.hideLoading()
            }
        }
    }
}
