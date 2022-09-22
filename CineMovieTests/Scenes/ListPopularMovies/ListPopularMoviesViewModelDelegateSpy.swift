//
//  ListPopularMoviesViewModelDelegateSpy.swift
//  CineMovieTests
//
//  Created by Renan Consalter on 04/08/22.
//

import XCTest

@testable import CineMovie

final class ListPopularMoviesViewModelDelegateSpy: ListPopularMoviesViewModelDelegate {
    private(set) var showPaginationLoadingCalled = false
    func showPaginationLoading() {
        showPaginationLoadingCalled = true
    }

    private(set) var showLoadingCalled = false
    func showLoading() {
        showLoadingCalled = true
    }

    private(set) var hideLoadingCalled = false
    func hideLoading() {
        hideLoadingCalled = true
    }

    private(set) var reloadDataCalled = false
    func reloadData() {
        reloadDataCalled = true
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
