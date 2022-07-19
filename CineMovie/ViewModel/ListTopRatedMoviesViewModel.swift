//
//  ListTopRatedMoviesViewModel.swift
//  CineMovie
//
//  Created by Renan Consalter on 30/06/22.
//

import Foundation

protocol ListTopRatedMoviesViewModelDelegate: AnyObject {
    func didFindTopRatedMovies()
    func didFail(error: ErrorHandler)
}

final class ListTopRatedMoviesViewModel {
    
    private var service = MoviesService.shared
    private var movies: [Movie] = []

    private var currentPage: Int = 1
    private var isLoading: Bool = false
    
    weak var delegate: ListTopRatedMoviesViewModelDelegate?
    weak var coordinator: ListTopRatedMoviesCoordinator?
    
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
    
    func loadTopRatedMovies() {
        
        guard !isLoading else { return }
        
        isLoading = true
        
        service.getTopRatedMovies(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let topRatedMovies):
                self.movies.append(contentsOf: topRatedMovies.results)
                self.currentPage = topRatedMovies.page + 1
                self.delegate?.didFindTopRatedMovies()
            case .failure(let error):
                self.delegate?.didFail(error: error)
            }
        }
    }
}
