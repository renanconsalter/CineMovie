//
//  SearchMoviesViewModelTests.swift
//  CineMovieTests
//
//  Created by Renan Consalter on 04/08/22.
//

import XCTest

@testable import CineMovie

final class SearchMoviesViewModelTests: XCTestCase {
    private let serviceSpy = SearchMoviesServiceSpy()
    private let delegateSpy = SearchMoviesViewModelDelegateSpy()
    private let coordinatorSpy = SearchMoviesCoordinatorSpy()
    private lazy var sut = SearchMoviesViewModel(
        service: serviceSpy
    )
    
    func test_getMovieAtIndexPath_shouldReturnMovie() {
        // Given
        serviceSpy.searchMovieToBeReturned = .success(
            .fixture(
                results: [
                    Movie.fixture(title: "The Godfather"),
                    Movie.fixture(title: "The Batman"),
                    Movie.fixture(title: "The Joker"),
                ]
            )
        )
        
        // When
        sut.searchMovies(with: "The")
        let movie = sut.getMovie(at: IndexPath.init(row: 2, section: 1))
        
        // Then
        XCTAssertEqual(movie, Movie.fixture(title: "The Joker"))
    }
    
    func test_numberofRows_shouldReturnDataSourceCount() {
        // Given
        serviceSpy.searchMovieToBeReturned = .success(
            .fixture(
                results: [
                    Movie.fixture(),
                    Movie.fixture(),
                    Movie.fixture(),
                    Movie.fixture(),
                ]
            )
        )
        
        // When
        sut.searchMovies(with: "A")
        let numberOfRows = sut.numberOfRows()

        // Then
        XCTAssertEqual(numberOfRows, 4)
    }
    
    func test_setNavigationTitle_shouldSetTitleOnViewController() {
        // Given
        let title = "Search"
        sut.delegate = delegateSpy
        
        // When
        sut.setNavigationTitle()
        
        // Then
        XCTAssertTrue(delegateSpy.setNavigationTitleCalled)
        XCTAssertEqual(delegateSpy.setNavigationTitleValuePassed, title)
    }
    
    func test_didSelectRowAtIndexPath_shouldNavigateToDetails_usingCoordinator() {
        // Given
        sut.coordinator = coordinatorSpy
        serviceSpy.searchMovieToBeReturned = .success(
            .fixture(
                results: [
                    Movie.fixture(title: "The Godfather"),
                    Movie.fixture(title: "The Batman"),
                    Movie.fixture(title: "The Shawshank Redemption"),
                ]
            )
        )
        
        // When
        sut.searchMovies(with: "The")
        sut.didSelectRow(at: IndexPath.init(row: 1, section: 1))
        
        // Then
        XCTAssertTrue(coordinatorSpy.goToMovieDetailsCalled)
        XCTAssertEqual(coordinatorSpy.goToMovieDetailsPassed?.title, "The Batman")
    }
    
    func test_searchMovies_shouldCallServiceSearchMovies() {
        // Given
        let movieName = "The Godfather"
        
        // When
        sut.searchMovies(with: movieName)
        
        // Then
        XCTAssertEqual(serviceSpy.searchMovieQueryPassed, "The Godfather")
        XCTAssertTrue(serviceSpy.searchMovieCalled)
    }
    
    func test_searchMovies_shouldCallServiceSearchMovies_titleCountTimes() {
        // Given
        let title = "Batman"

        // When
        sut.searchMovies(with: title)
        
        // Then
        XCTAssertEqual(serviceSpy.searchMovieQueryPassed, "Batman")
        XCTAssertEqual(serviceSpy.searchMovieCallCount, 1)
        XCTAssertEqual(serviceSpy.searchMovieQueryPassedCharacterCount, title.count)
    }
    
    func test_searchMovies_shouldTrigger_showEmptyState() {
        // Given
        sut.delegate = delegateSpy

        // Whem
        sut.searchMovies(with: "")

        // Then
        XCTAssertTrue(delegateSpy.showEmptyStateCalled)
    }
    
    func test_searchMovies_shouldTrigger_showNoResultsState() {
        // Given
        serviceSpy.searchMovieToBeReturned = .success(
            .fixture(
                results: []
            )
        )
        sut.delegate = delegateSpy

        // When
        sut.searchMovies(with: "no_results")

        // Then
        XCTAssertTrue(delegateSpy.showNoResultsStateCalled)
        XCTAssertEqual(serviceSpy.searchMovieQueryPassed, "no_results")
        XCTAssertTrue(delegateSpy.hideLoadingCalled)
    }
    
    func test_searchMovies_shouldTrigger_reloadData() {
        // Given
        serviceSpy.searchMovieToBeReturned = .success(
            .fixture(
                results: [
                    Movie.fixture(title: "Schindler's List"),
                    Movie.fixture(title: "Impossible Things"),
                    Movie.fixture(title: "Parasite"),
                    Movie.fixture(title: "The Green Mile"),
                    Movie.fixture(title: "The Dark Knight"),
                ]
            )
        )
        sut.delegate = delegateSpy

        // When
        sut.searchMovies(with: "i")

        // Then
        XCTAssertTrue(delegateSpy.reloadDataCalled)
        XCTAssertEqual(serviceSpy.searchMovieQueryPassed, "i")
        XCTAssertTrue(delegateSpy.hideLoadingCalled)
    }
    
    func test_searchMovies_shouldTrigger_didFail_withError() {
        // Given
        let fakeError = ErrorHandler.unknown
        serviceSpy.searchMovieToBeReturned = .failure(fakeError)
        sut.delegate = delegateSpy

        // When
        sut.searchMovies(with: "error")

        // Then
        XCTAssertTrue(delegateSpy.didFailCalled)
        XCTAssertEqual(serviceSpy.searchMovieQueryPassed, "error")
        XCTAssertTrue(delegateSpy.hideLoadingCalled)
    }
}
