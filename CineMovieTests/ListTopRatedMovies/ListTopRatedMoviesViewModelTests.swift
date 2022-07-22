//
//  ListTopRatedMoviesViewModelTests.swift
//  CineMovieTests
//
//  Created by Renan Consalter on 21/07/22.
//

import XCTest

@testable import CineMovie

final class ListTopRatedMoviesViewModelTests: XCTestCase {
    private let serviceSpy = MoviesServiceSpy()
    private let delegateSpy = ListTopRatedMoviesViewModelDelegateSpy()
    private lazy var sut = ListTopRatedMoviesViewModel(
        service: serviceSpy
    )
    
    func test_loadTopRatedMovies_shouldCallServiceGetTopRatedMovies() {
        sut.loadTopRatedMovies()
        
        XCTAssertTrue(serviceSpy.getTopRatedMoviesCalled)
    }
    
    func test_loadTopRatedMovies_shouldCallServiceGetTopRatedMoviesOnce() {
        sut.loadTopRatedMovies()
        
        XCTAssertEqual(serviceSpy.getTopRatedMoviesCallCount, 1)
    }
    
    func test_loadTopRatedMovies_shouldTrigger_success_delegate() {
        serviceSpy.getTopRatedMoviesToBeReturned = .success(.fixture())
        sut.delegate = delegateSpy
        
        sut.loadTopRatedMovies()
        
        XCTAssertNotNil(delegateSpy)
        XCTAssertTrue(delegateSpy.didFindTopRatedMoviesCalled)
    }
    
    func test_loadTopRatedMovies_shouldTrigger_didFail_delegate() {
        serviceSpy.getTopRatedMoviesToBeReturned = .failure(ErrorHandler.invalidData)
        sut.delegate = delegateSpy
        
        sut.loadTopRatedMovies()
        
        XCTAssertNotNil(delegateSpy)
        XCTAssertTrue(delegateSpy.didFailCalled)
    }
}
