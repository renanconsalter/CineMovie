//
//  SearchMoviesViewModel.swift
//  CineMovie
//
//  Created by Renan Consalter on 04/07/22.
//

import Foundation

protocol SearchMoviesViewModelDelegate: AnyObject {
    func didFindMovies()
    func didFail(error: ErrorHandler)
    func didSelectMovie(movie: Movie)
    func showEmptyState()
    func showNoResultsState()
}

final class SearchMoviesViewModel {

    private var service = MoviesService.shared
    
    private var movies: [Movie] = []
    
    weak var delegate: SearchMoviesViewModelDelegate?
    
    func getMovie(at indexPath: IndexPath) -> Movie {
        return movies[indexPath.row]
    }
    
    func numberOfRows() -> Int {
        return movies.count
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        self.delegate?.didSelectMovie(movie: movie)
    }
    
    func searchMovies(with query: String) {
        let characterCount = query.count
        
        switch characterCount {
        case 0:
            self.movies = []
            self.delegate?.showEmptyState()
        default:
            service.searchMovie(query: query) { result in
                switch result {
                case .success(let movies):
                    let noResults = movies.results.isEmpty
                    self.movies = movies.results
                    
                    if noResults {
                        self.delegate?.showNoResultsState()
                    } else {
                        self.delegate?.didFindMovies()
                    }
                case .failure(let error):
                    self.delegate?.didFail(error: error)
                }
            }
        }
    }
}

