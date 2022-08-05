//
//  SearchMoviesViewModelTests.swift
//  CineMovieTests
//
//  Created by Renan Consalter on 04/08/22.
//

import XCTest

@testable import CineMovie

final class SearchMoviesViewModelTests: XCTestCase {
    private let serviceSpy = MoviesServiceSpy()
    private let delegateSpy = SearchMoviesViewModelDelegateSpy()
    private let coordinatorSpy = SearchMoviesCoordinatorSpy()
    private lazy var sut = SearchMoviesViewModel(
        service: serviceSpy
    )
    
    func test_getMovieAtIndexPath_shouldReturnMovie() {
        sut.movies = [
            Movie.fixture(title: "The Godfather"),
            Movie.fixture(title: "Batman"),
            Movie.fixture(title: "The Joker"),
        ]
        
        let movie = sut.getMovie(at: IndexPath.init(row: 2, section: 1))
        
        XCTAssertEqual(movie, Movie.fixture(title: "The Joker"))
    }
    
    func test_numberofRow_shouldReturnDataSourceCount() {
        sut.movies = [
            Movie.fixture(),
            Movie.fixture(),
            Movie.fixture(),
            Movie.fixture(),
        ]
        
        let numberOfRows = sut.numberOfRows()

        XCTAssertEqual(numberOfRows, 4)
    }
    
    func test_didSelectRowAtIndexPath_shouldNavigateToDetails_usingCoordinator() {
        sut.coordinator = coordinatorSpy
        sut.movies = [
            Movie.fixture(title: "The Godfather"),
            Movie.fixture(title: "Batman"),
            Movie.fixture(title: "The Joker"),
        ]
        
        sut.didSelectRow(at: IndexPath.init(row: 1, section: 1))
        
        XCTAssertTrue(coordinatorSpy.goToMovieDetailsCalled)
        XCTAssertEqual(coordinatorSpy.goToMovieDetailsPassed?.title, "Batman")
    }
    
    func test_searchMovies_shouldCallServiceSearchMovies() {
        sut.searchMovies(with: "The Godfather")
        
        XCTAssertEqual(serviceSpy.searchMovieQueryPassed, "The Godfather")
        XCTAssertTrue(serviceSpy.searchMovieCalled)
    }
    
    func test_searchMovies_shouldCallServiceSearchMovies_titleCountTimes() {
        let title = "Batman"

        sut.searchMovies(with: title)
        
        XCTAssertEqual(serviceSpy.searchMovieQueryPassed, "Batman")
        XCTAssertEqual(serviceSpy.searchMovieCallCount, title.count)
    }
    
    func test_searchMovies_shouldTrigger_didFail_delegate() {
        let fakeError = ErrorHandler.unknown
        serviceSpy.searchMovieToBeReturned = .failure(fakeError)
        sut.delegate = delegateSpy

        sut.searchMovies(with: "error")

        XCTAssertNotNil(delegateSpy)
        XCTAssertTrue(delegateSpy.didFailCalled)
        XCTAssertEqual(serviceSpy.searchMovieQueryPassed, "error")
    }
    
    func test_searchMovies_shouldTrigger_showEmptyState_delegate() {
        sut.delegate = delegateSpy

        sut.searchMovies(with: "")

        XCTAssertNotNil(delegateSpy)
        XCTAssertTrue(delegateSpy.showEmptyStateCalled)
    }
    
    func test_searchMovies_shouldTrigger_showNoResultsState_delegate() {
        serviceSpy.searchMovieToBeReturned = .success(
            .fixture(
                results: []
            )
        )
        sut.delegate = delegateSpy

        sut.searchMovies(with: "no_results")

        XCTAssertNotNil(delegateSpy)
        XCTAssertTrue(delegateSpy.showNoResultsStateCalled)
        XCTAssertEqual(serviceSpy.searchMovieQueryPassed, "no_results")
    }
    
    func test_searchMovies_shouldTrigger_didFindMovies_delegate() {
        serviceSpy.searchMovieToBeReturned = .success(
            .fixture(
                results: [
                    Movie.fixture(title: "ABC"),
                    Movie.fixture(title: "ABCD"),
                    Movie.fixture(title: "ABCDE"),
                    Movie.fixture(title: "ABCDEF"),
                    Movie.fixture(title: "ABCDEFG"),
                ]
            )
        )
        sut.delegate = delegateSpy

        sut.searchMovies(with: "ABC")

        XCTAssertNotNil(delegateSpy)
        XCTAssertTrue(delegateSpy.didFindMoviesCalled)
        XCTAssertEqual(serviceSpy.searchMovieQueryPassed, "ABC")
    }
}
