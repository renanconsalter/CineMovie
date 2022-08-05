//
//  ListPopularMoviesViewModelTests.swift
//  CineMovieTests
//
//  Created by Renan Consalter on 04/08/22.
//

import XCTest

@testable import CineMovie

final class ListPopularMoviesViewModelTests: XCTestCase {
    private let serviceSpy = MoviesServiceSpy()
    private let delegateSpy = ListPopularMoviesViewModelDelegateSpy()
    private let coordinatorSpy = ListPopularMoviesCoordinatorSpy()
    private lazy var sut = ListPopularMoviesViewModel(
        service: serviceSpy
    )
    
    func test_loadPopularMovies_shouldCallServiceGetPopularMovies() {
        sut.loadPopularMovies()
        
        XCTAssertTrue(serviceSpy.getPopularMoviesCalled)
    }
    
    func test_loadPopularMovies_shouldCallServiceGetPopularMoviesOnce() {
        sut.loadPopularMovies()
        
        XCTAssertEqual(serviceSpy.getPopularMoviesCallCount, 1)
    }
    
    func test_loadPopularMovies_shouldTrigger_success_delegate() {
        serviceSpy.getPopularMoviesToBeReturned = .success(.fixture())
        sut.delegate = delegateSpy
        
        sut.loadPopularMovies()
        
        XCTAssertNotNil(delegateSpy)
        XCTAssertTrue(delegateSpy.didFindPopularMoviesCalled)
    }
    
    func test_loadPopularMovies_shouldTrigger_didFail_delegate() {
        let fakeError = ErrorHandler.unknown
        serviceSpy.getPopularMoviesToBeReturned = .failure(fakeError)
        sut.delegate = delegateSpy
        
        sut.loadPopularMovies()
        
        XCTAssertNotNil(delegateSpy)
        XCTAssertTrue(delegateSpy.didFailCalled)
    }
    
    func test_getMovieAtIndexPath_shouldReturnMovie() {
        sut.movies = [
            Movie.fixture(posterPath: "/image1.jpg"),
            Movie.fixture(posterPath: "/image2.jpg"),
            Movie.fixture(posterPath: "/image3.jpg"),
        ]
        
        let movie = sut.getMovie(at: IndexPath.init(row: 2, section: 1))
        
        XCTAssertEqual(movie, Movie.fixture(posterPath: "/image3.jpg"))
    }
    
    func test_numberofRow_shouldReturnDataSourceCount() {
        sut.movies = [
            Movie.fixture(),
            Movie.fixture(),
            Movie.fixture(),
            Movie.fixture(),
            Movie.fixture(),
            Movie.fixture(),
            Movie.fixture(),
            Movie.fixture(),
            Movie.fixture(),
        ]
        
        let numberOfRows = sut.numberOfRows()

        XCTAssertEqual(numberOfRows, 9)
    }
    
    func test_didSelectRowAtIndexPath_shouldNavigateToDetails_usingCoordinator() {
        sut.coordinator = coordinatorSpy
        sut.movies = [
            Movie.fixture(id: 23),
            Movie.fixture(id: 45),
            Movie.fixture(id: 67),
            Movie.fixture(id: 33)
        ]
        
        sut.didSelectItem(at: IndexPath.init(row: 2, section: 1))
        
        XCTAssertTrue(coordinatorSpy.goToMovieDetailsCalled)
        XCTAssertEqual(coordinatorSpy.goToMovieDetailsPassed?.id, 67)
    }
}
