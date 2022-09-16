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
    
    func didLoadMovieDetails() {
        didLoadMovieDetailsCalled = true
    }
    
    private(set) var didFailCalled: Bool = false
    
    func didFail(with error: ErrorHandler) {
        didFailCalled = true
    }
    
    private(set) var showLoadingStateCalled: Bool = false
    
    func showLoading() {
        showLoadingStateCalled = true
    }
    
    private(set) var hideLoadingCalled: Bool = false
    
    func hideLoading() {
        hideLoadingCalled = true
    }
}
