//
//  MoviesServiceSpy.swift
//  CineMovieTests
//
//  Created by Renan Consalter on 21/07/22.
//

import XCTest

@testable import CineMovie

final class MoviesServiceSpy: MoviesServiceProtocol {
    
    // MARK: - getTopRatedMovies
    var getTopRatedMoviesToBeReturned: ResultMovies?
    private(set) var getTopRatedMoviesCalled: Bool = false
    private(set) var getTopRatedMoviesCallCount: Int = 0
    private(set) var pagePassed: Int?
    
    func getTopRatedMovies(page: Int, completion: @escaping (ResultMovies) -> Void) {
        pagePassed = page
        getTopRatedMoviesCalled = true
        getTopRatedMoviesCallCount += 1
        
        guard let getTopRatedMoviesToBeReturned = getTopRatedMoviesToBeReturned else {
            return completion(.failure(ErrorHandler.decode))
        }
        
        return completion(getTopRatedMoviesToBeReturned)
    }
    
    // MARK: - getPopularMovies
    func getPopularMovies(page: Int, completion: @escaping (ResultMovies) -> Void) { }
    
    // MARK: - searchMovie
    func searchMovie(query: String, completion: @escaping (ResultMovies) -> Void) { }
    
    // MARK: - getMovie
    func getMovie(id: Int, completion: @escaping (Result<Movie, ErrorHandler>) -> Void) { }
}
