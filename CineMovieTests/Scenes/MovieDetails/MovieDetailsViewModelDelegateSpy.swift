//
//  MovieDetailsViewModelDelegateSpy.swift
//  CineMovieTests
//
//  Created by Renan Consalter on 04/08/22.
//

import XCTest

@testable import CineMovie

final class MovieDetailsViewModelDelegateSpy: MovieDetailsViewModelDelegate {
    private(set) var didLoadMovieDetailsCalled = false
    func didLoadMovieDetails() {
        didLoadMovieDetailsCalled = true
    }

    private(set) var didFailCalled = false
    private(set) var didFailErrorPassed: ErrorHandler?
    func didFail(with error: ErrorHandler) {
        didFailCalled = true
        didFailErrorPassed = error
    }

    private(set) var showLoadingStateCalled = false
    func showLoading() {
        showLoadingStateCalled = true
    }

    private(set) var hideLoadingCalled = false
    func hideLoading() {
        hideLoadingCalled = true
    }
}
