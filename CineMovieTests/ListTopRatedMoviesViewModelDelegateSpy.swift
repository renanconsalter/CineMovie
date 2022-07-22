//
//  ListTopRatedMoviesViewModelDelegateSpy.swift
//  CineMovieTests
//
//  Created by Renan Consalter on 21/07/22.
//

import XCTest

@testable import CineMovie

final class ListTopRatedMoviesViewModelDelegateSpy: ListTopRatedMoviesViewModelDelegate {
    private(set) var didFindTopRatedMoviesCalled: Bool = false
    private(set) var didFailCalled: Bool = false
    
    func didFindTopRatedMovies() {
        didFindTopRatedMoviesCalled = true
    }
    
    func didFail(error: ErrorHandler) {
        didFailCalled = true
    }
}
