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
    private(set) var getTopRatedMoviesPagePassed: Int?
    
    func getTopRatedMovies(page: Int, completion: @escaping (ResultMovies) -> Void) {
        
        getTopRatedMoviesPagePassed = page
        getTopRatedMoviesCalled = true
        getTopRatedMoviesCallCount += 1
        
        guard let getTopRatedMoviesToBeReturned = getTopRatedMoviesToBeReturned else {
            return completion(.failure(ErrorHandler.noResponse))
        }
        
        return completion(getTopRatedMoviesToBeReturned)
    }
    
    // MARK: - getPopularMovies
    var getPopularMoviesToBeReturned: ResultMovies?
    private(set) var getPopularMoviesCalled: Bool = false
    private(set) var getPopularMoviesCallCount: Int = 0
    private(set) var getPopularMoviesPagePassed: Int?
    
    func getPopularMovies(page: Int, completion: @escaping (ResultMovies) -> Void) {
        
        getPopularMoviesPagePassed = page
        getPopularMoviesCalled = true
        getPopularMoviesCallCount += 1
        
        guard let getPopularMoviesToBeReturned = getPopularMoviesToBeReturned else {
            return completion(.failure(ErrorHandler.noResponse))
        }
        
        return completion(getPopularMoviesToBeReturned)
    }
    
    // MARK: - searchMovie
    var searchMovieToBeReturned: ResultMovies?
    private(set) var searchMovieCalled: Bool = false
    private(set) var searchMovieCallCount: Int = 0
    private(set) var searchMovieQueryPassed: String?
    
    func searchMovie(query: String, completion: @escaping (ResultMovies) -> Void) {
        
        searchMovieCalled = true
        searchMovieCallCount = query.count
        searchMovieQueryPassed = query
        
        guard let searchMovieToBeReturned = searchMovieToBeReturned else {
            return completion(.failure(ErrorHandler.noResponse))
        }
        
        return completion(searchMovieToBeReturned)
        
    }
    
    // MARK: - getMovie
    var getMovieToBeReturned: Movie?
    private(set) var getMovieCalled: Bool = false
    private(set) var getMovieCount: Int = 0
    private(set) var getMovieIdPassed: Int?
    
    func getMovie(id: Int, completion: @escaping (Result<Movie, ErrorHandler>) -> Void) {
        
        getMovieCalled = true
        getMovieCount += 1
        getMovieIdPassed = id
        
        guard let getMovieToBeReturned = getMovieToBeReturned else {
            return completion(.failure(ErrorHandler.noResponse))
        }
        
        return completion(.success(getMovieToBeReturned))
    }
}
