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
    private let coordinatorSpy = ListTopRatedMoviesCoordinatorSpy()
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
        let fakeError = ErrorHandler.unknown
        serviceSpy.getTopRatedMoviesToBeReturned = .failure(fakeError)
        sut.delegate = delegateSpy
        
        sut.loadTopRatedMovies()
        
        XCTAssertNotNil(delegateSpy)
        XCTAssertTrue(delegateSpy.didFailCalled)
    }
    
    func test_getMovieAtIndexPath_shouldReturnMovie() {
        sut.movies = [
            Movie.fixture(title: "The Godfather"),
            Movie.fixture(title: "The Shawshank Redemption"),
            Movie.fixture(title: "Thor"),
            Movie.fixture(title: "The Black Phone")
        ]
        
        let movie = sut.getMovie(at: IndexPath.init(row: 2, section: 1))
        
        XCTAssertEqual(movie, Movie.fixture(title: "Thor"))
    }
    
    func test_numberofRow_shouldReturnDataSourceCount() {
        sut.movies = [
            Movie.fixture(),
            Movie.fixture(),
            Movie.fixture(),
        ]
        
        let numberOfRows = sut.numberOfRows()

        XCTAssertEqual(numberOfRows, 3)
    }
    
    func test_didSelectRowAtIndexPath_shouldNavigateToDetails_usingCoordinator() {
        sut.coordinator = coordinatorSpy
        sut.movies = [
            Movie.fixture(title: "The Godfather"),
            Movie.fixture(title: "The Shawshank Redemption"),
            Movie.fixture(title: "Thor"),
            Movie.fixture(title: "The Black Phone")
        ]
        
        sut.didSelectRow(at: IndexPath.init(row: 2, section: 1))
        
        XCTAssertTrue(coordinatorSpy.goToMovieDetailsCalled)
        XCTAssertEqual(coordinatorSpy.goToMovieDetailsPassed?.title, "Thor")
    }
}
