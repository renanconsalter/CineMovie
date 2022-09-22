//
//  MovieDetailsCoordinatorSpy.swift
//  CineMovieTests
//
//  Created by Renan Consalter on 04/08/22.
//

import XCTest

@testable import CineMovie

final class MovieDetailsCoordinatorSpy: MovieDetailsCoordinatorProtocol {
    private(set) var dismissMovieDetailsCalled = false
    func dismissMovieDetails() {
        dismissMovieDetailsCalled = true
    }
}
