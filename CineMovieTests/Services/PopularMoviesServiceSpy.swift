//
//  PopularMoviesServiceSpy.swift
//  CineMovieTests
//
//  Created by Renan Consalter on 30/08/22.
//

import XCTest

@testable import CineMovie

final class PopularMoviesServiceSpy: PopularMoviesServiceProtocol {
    var getPopularMoviesToBeReturned: (Result<MoviesResponse, ErrorHandler>)?
    private(set) var getPopularMoviesCalled = false
    private(set) var getPopularMoviesCallCount: Int = 0
    private(set) var getPopularMoviesPagePassed: Int?

    func getPopularMovies(page: Int, completion: @escaping (Result<MoviesResponse, ErrorHandler>) -> Void) {
        getPopularMoviesCalled = true
        getPopularMoviesCallCount += 1
        getPopularMoviesPagePassed = page

        guard let getPopularMoviesToBeReturned = getPopularMoviesToBeReturned else {
            return completion(.failure(ErrorHandler.noResponse))
        }

        return completion(getPopularMoviesToBeReturned)
    }
}
