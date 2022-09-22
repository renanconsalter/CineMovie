//
//  SearchMoviesServiceSpy.swift
//  CineMovieTests
//
//  Created by Renan Consalter on 30/08/22.
//

import XCTest

@testable import CineMovie

final class SearchMoviesServiceSpy: SearchMoviesServiceProtocol {
    var searchMovieToBeReturned: (Result<MoviesResponse, ErrorHandler>)?
    private(set) var searchMovieCalled = false
    private(set) var searchMovieCallCount: Int = 0
    private(set) var searchMovieQueryPassedCharacterCount: Int?
    private(set) var searchMovieQueryPassed: String?

    func searchMovie(query: String, completion: @escaping (Result<MoviesResponse, ErrorHandler>) -> Void) {
        searchMovieCalled = true
        searchMovieCallCount += 1
        searchMovieQueryPassed = query
        searchMovieQueryPassedCharacterCount = query.count

        guard let searchMovieToBeReturned = searchMovieToBeReturned else {
            return completion(.failure(ErrorHandler.noResponse))
        }

        return completion(searchMovieToBeReturned)
    }
}
