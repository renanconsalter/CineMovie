//
//  MovieDetailsServiceSpy.swift
//  CineMovieTests
//
//  Created by Renan Consalter on 30/08/22.
//

import XCTest

@testable import CineMovie

final class MovieDetailsServiceSpy: MovieDetailsServiceProtocol {
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
