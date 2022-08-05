//
//  ListPopularMoviesCoordinatorSpy.swift
//  CineMovieTests
//
//  Created by Renan Consalter on 04/08/22.
//

import XCTest

@testable import CineMovie

final class ListPopularMoviesCoordinatorSpy: MovieDetailsCoordinatorProtocol {
    
    private(set) var goToMovieDetailsCalled = false
    private(set) var goToMovieDetailsPassed: Movie?
    
    func goToMovieDetails(with movie: Movie) {
        goToMovieDetailsCalled = true
        goToMovieDetailsPassed = movie
    }
}
