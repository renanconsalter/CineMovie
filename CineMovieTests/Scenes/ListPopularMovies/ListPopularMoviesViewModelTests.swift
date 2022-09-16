//
//  ListPopularMoviesViewModelTests.swift
//  CineMovieTests
//
//  Created by Renan Consalter on 04/08/22.
//

import XCTest

@testable import CineMovie

final class ListPopularMoviesViewModelTests: XCTestCase {
    private let serviceSpy = PopularMoviesServiceSpy()
    private let delegateSpy = ListPopularMoviesViewModelDelegateSpy()
    private let coordinatorSpy = ListPopularMoviesCoordinatorSpy()
    private lazy var sut = ListPopularMoviesViewModel(
        service: serviceSpy
    )
    
    func test_getMovieAtIndexPath_shouldReturnMovie() {
        // Given
        serviceSpy.getPopularMoviesToBeReturned = .success(
            .fixture(
                results: [
                    Movie.fixture(posterPath: "/image1.jpg"),
                    Movie.fixture(posterPath: "/image2.jpg"),
                    Movie.fixture(posterPath: "/image3.jpg")
                ]
            )
        )
        
        // When
        sut.loadPopularMovies()
        let movie = sut.getMovie(at: IndexPath.init(row: 2, section: 1))
        
        // Then
        XCTAssertEqual(movie, Movie.fixture(posterPath: "/image3.jpg"))
    }
    
    func test_numberofRow_shouldReturnDataSourceCount() {
        // Given
        serviceSpy.getPopularMoviesToBeReturned = .success(
            .fixture(
                results: [
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
            )
        )
        
        // When
        sut.loadPopularMovies()
        let numberOfRows = sut.numberOfRows()

        // Then
        XCTAssertEqual(numberOfRows, 9)
    }
    
    func test_didSelectRowAtIndexPath_shouldNavigateToDetails_usingCoordinator() {
        // Given
        sut.coordinator = coordinatorSpy
        serviceSpy.getPopularMoviesToBeReturned = .success(
            .fixture(
                results: [
                    Movie.fixture(id: 23),
                    Movie.fixture(id: 45),
                    Movie.fixture(id: 67),
                    Movie.fixture(id: 33)
                ]
            )
        )
        
        // When
        sut.loadPopularMovies()
        sut.didSelectItem(at: IndexPath.init(row: 2, section: 1))
        
        // Then
        XCTAssertTrue(coordinatorSpy.goToMovieDetailsCalled)
        XCTAssertEqual(coordinatorSpy.goToMovieDetailsPassed?.id, 67)
    }
    
    func test_setNavigationTitle_shouldSetTitleOnViewController() {
        // Given
        let title = "Popular"
        sut.delegate = delegateSpy
        
        // When
        sut.setNavigationTitle()
        
        // Then
        XCTAssertTrue(delegateSpy.setNavigationTitleCalled)
        XCTAssertEqual(delegateSpy.setNavigationTitleValuePassed, title)
    }
    
    func test_loadPopularMovies_firstCall_shouldShowLoading_and_sendPageOneToService() {
        // Given
        let page = 1
        sut.delegate = delegateSpy
        
        // When
        sut.loadPopularMovies()
        
        // Then
        XCTAssertTrue(delegateSpy.showLoadingCalled)
        XCTAssertEqual(page, serviceSpy.getPopularMoviesPagePassed)
    }
    
    func test_userRequestedMoreData_shouldCallService_oneTime() {
        // Given
        let callCount = 1
        sut.delegate = delegateSpy
        
        // When
        sut.userRequestedMoreData()
        
        // Then
        XCTAssertTrue(delegateSpy.showPaginationLoadingCalled)
        XCTAssertTrue(serviceSpy.getPopularMoviesCalled)
        XCTAssertEqual(serviceSpy.getPopularMoviesCallCount, callCount)
    }
    
    func test_userRequestedMoreData_shouldShowLoading_and_callService() {
        // Given
        sut.delegate = delegateSpy

        // When
        sut.userRequestedMoreData()

        // Then
        XCTAssertTrue(delegateSpy.showPaginationLoadingCalled)
        XCTAssertTrue(serviceSpy.getPopularMoviesCalled)
    }
    
    func test_getPopularMovies_firstCall_shouldPaginate_toPageTwo() {
        // Given
        let page = 2
        serviceSpy.getPopularMoviesToBeReturned = .success(.fixture(page: 1))
        sut.delegate = delegateSpy
        sut.loadPopularMovies()
        
        // When
        sut.userRequestedMoreData()
        
        // Then
        XCTAssertTrue(delegateSpy.reloadDataCalled)
        XCTAssertEqual(serviceSpy.getPopularMoviesPagePassed, page)
        XCTAssertEqual(serviceSpy.getPopularMoviesCallCount, 2)
        XCTAssertTrue(delegateSpy.hideLoadingCalled)
    }
    
    func test_getPopularMovies_shouldPaginate_manyTimesServiceIsCalled() {
        // Given
        let finalPage = 5
        let callCount = 5
        sut.delegate = delegateSpy
        
        // When
        for i in 1...callCount {
            serviceSpy.getPopularMoviesToBeReturned = .success(.fixture(page: i))
            sut.userRequestedMoreData()
        }

        // Then
        XCTAssertTrue(delegateSpy.reloadDataCalled)
        XCTAssertEqual(serviceSpy.getPopularMoviesPagePassed, finalPage)
        XCTAssertEqual(serviceSpy.getPopularMoviesCallCount, callCount)
        XCTAssertTrue(delegateSpy.hideLoadingCalled)
    }
    
    func test_getPopularMovies_withSuccess_shouldReloadData() {
        // Given
        serviceSpy.getPopularMoviesToBeReturned = .success(.fixture())
        sut.delegate = delegateSpy
        
        // When
        sut.loadPopularMovies()
        
        // Then
        XCTAssertTrue(delegateSpy.reloadDataCalled)
        XCTAssertTrue(delegateSpy.hideLoadingCalled)
    }
    
    func test_getPopularMovies_shouldFail_withError() {
        // Given
        let fakeError = ErrorHandler.invalidData
        serviceSpy.getPopularMoviesToBeReturned = .failure(fakeError)
        sut.delegate = delegateSpy
        
        // When
        sut.loadPopularMovies()
        
        // Then
        XCTAssertTrue(delegateSpy.didFailCalled)
        XCTAssertEqual(delegateSpy.didFailErrorPassed, fakeError)
        XCTAssertTrue(delegateSpy.hideLoadingCalled)
    }
}
