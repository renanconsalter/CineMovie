//
//  ListPopularMoviesViewModelDelegateSpy.swift
//  CineMovieTests
//
//  Created by Renan Consalter on 04/08/22.
//

import XCTest

@testable import CineMovie

final class ListPopularMoviesViewModelDelegateSpy: ListPopularMoviesViewModelDelegate {
    private(set) var didFindPopularMoviesCalled: Bool = false
    private(set) var didFailCalled: Bool = false
    
    func didFindPopularMovies() {
        didFindPopularMoviesCalled = true
    }
    
    func didFail(error: ErrorHandler) {
        didFailCalled = true
    }
}
