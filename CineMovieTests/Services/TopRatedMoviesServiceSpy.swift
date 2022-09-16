//
//  TopRatedMoviesServiceSpy.swift
//  CineMovieTests
//
//  Created by Renan Consalter on 30/08/22.
//

import XCTest

@testable import CineMovie

final class TopRatedMoviesServiceSpy: TopRatedMoviesServiceProtocol {
    var getTopRatedMoviesToBeReturned: (Result<MoviesResponse, ErrorHandler>)?
    private(set) var getTopRatedMoviesCalled: Bool = false
    private(set) var getTopRatedMoviesCallCount: Int = 0
    private(set) var getTopRatedMoviesPagePassed: Int?
    
    func getTopRatedMovies(page: Int, completion: @escaping (Result<MoviesResponse, ErrorHandler>) -> Void) {
        
        getTopRatedMoviesCalled = true
        getTopRatedMoviesCallCount += 1
        getTopRatedMoviesPagePassed = page

        guard let getTopRatedMoviesToBeReturned = getTopRatedMoviesToBeReturned else {
            return completion(.failure(ErrorHandler.noResponse))
        }
        
        return completion(getTopRatedMoviesToBeReturned)
    }
}
