//
//  SearchMoviesViewModelDelegateSpy.swift
//  CineMovieTests
//
//  Created by Renan Consalter on 04/08/22.
//

import XCTest

@testable import CineMovie

final class SearchMoviesViewModelDelegateSpy: SearchMoviesViewModelDelegate {
    private(set) var showTableViewHeaderLoadingCalled = false
    func showTableViewHeaderLoading() {
        showTableViewHeaderLoadingCalled = true
    }

    private(set) var hideLoadingCalled = false
    func hideLoading() {
        hideLoadingCalled = true
    }

    private(set) var reloadDataCalled = false
    func reloadData() {
        reloadDataCalled = true
    }

    private(set) var showEmptyStateCalled = false
    func showEmptyState() {
        showEmptyStateCalled = true
    }

    private(set) var showNoResultsStateCalled = false
    func showNoResultsState() {
        showNoResultsStateCalled = true
    }

    private(set) var didFailCalled = false
    private(set) var didFailErrorPassed: ErrorHandler?
    func didFail(with error: ErrorHandler) {
        didFailCalled = true
        didFailErrorPassed = error
    }

    private(set) var setNavigationTitleCalled = false
    private(set) var setNavigationTitleValuePassed: String?
    func setNavigationTitle(to value: String) {
        setNavigationTitleCalled = true
        setNavigationTitleValuePassed = value
    }
}
