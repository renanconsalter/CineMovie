//
//  SearchMoviesViewModelDelegateSpy.swift
//  CineMovieTests
//
//  Created by Renan Consalter on 04/08/22.
//

import XCTest

@testable import CineMovie

final class SearchMoviesViewModelDelegateSpy: SearchMoviesViewModelDelegate {
    private(set) var didFindMoviesCalled: Bool = false
    private(set) var showEmptyStateCalled: Bool = false
    private(set) var showNoResultsStateCalled: Bool = false
    private(set) var didFailCalled: Bool = false
    
    func didFindMovies() {
        didFindMoviesCalled = true
    }
    
    func showEmptyState() {
        showEmptyStateCalled = true
    }
    
    func showNoResultsState() {
        showNoResultsStateCalled = true
    }
    
    func didFail(error: ErrorHandler) {
        didFailCalled = true
    }
}

