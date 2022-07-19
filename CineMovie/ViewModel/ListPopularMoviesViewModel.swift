//
//  ListPopularMoviesViewModel.swift
//  CineMovie
//
//  Created by Renan Consalter on 04/07/22.
//

import Foundation

protocol ListPopularMoviesViewModelDelegate: AnyObject {
    func didFindPopularMovies()
    func didFail(error: ErrorHandler)
}

final class ListPopularMoviesViewModel {
    
    private var service = MoviesService.shared
    private var movies: [Movie] = []
    
    private var currentPage: Int = 1
    private var isLoading: Bool = false
    
    weak var delegate: ListPopularMoviesViewModelDelegate?
    weak var coordinator: ListPopularMoviesCoordinator?
    
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
    
    func loadPopularMovies() {
        guard !isLoading else { return }
        
        isLoading = true
        
        service.getPopularMovies(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let popularMovies):
                self.movies.append(contentsOf: popularMovies.results)
                self.currentPage = popularMovies.page + 1
                self.delegate?.didFindPopularMovies()
            case .failure(let error):
                self.delegate?.didFail(error: error)
            }
        }
    }
}
