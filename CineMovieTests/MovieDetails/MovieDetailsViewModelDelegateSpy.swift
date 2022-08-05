//
//  MovieDetailsViewModelDelegateSpy.swift
//  CineMovieTests
//
//  Created by Renan Consalter on 04/08/22.
//

import XCTest

@testable import CineMovie

final class MovieDetailsViewModelDelegateSpy: MovieDetailsViewModelDelegate {
    
    private(set) var didLoadMovieDetailsCalled: Bool = false
    private(set) var didFailCalled: Bool = false
    
    func didLoadMovieDetails() {
        didLoadMovieDetailsCalled = true
    }
    
    func didFail(error: ErrorHandler) {
        didFailCalled = true
    }
}
