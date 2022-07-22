//
//  TopRatedMoviesCellViewModelTests.swift
//  CineMovieTests
//
//  Created by Renan Consalter on 21/07/22.
//

import XCTest

@testable import CineMovie

final class TopRatedMoviesCellViewModelTests: XCTestCase {
    // MARK: - PosterPath Image
    func test_topRatedMoviesCell_whenPosterPathIsValid_and_notNil() {
        // Given
        let posterImageBaseURL = Constants.ApiImageURL.lowQuality
        let posterPathToTest = "/poster.jpg"
        let viewModelToTest = createSUT(
            with: Movie.fixture(posterPath: posterPathToTest)
        )
        
        // When
        let viewModelPosterImageURL = viewModelToTest.posterImageURL
        let completePosterImageURL = posterImageBaseURL + posterPathToTest
        
        // Then
        XCTAssertNotNil(posterPathToTest)
        XCTAssertNotNil(posterImageBaseURL)
        XCTAssertNotNil(completePosterImageURL)
    
        XCTAssertEqual(completePosterImageURL, viewModelPosterImageURL)
    }
    
    func test_topRatedMoviesCell_whenPosterPathIsNil_or_doesntExist_shouldReturnPlaceholder() {
        // Given
        let posterPlaceholder = Constants.ApiImageURL.posterPlaceholder
        let viewModelToTest = createSUT(
            with: Movie.fixture(posterPath: nil)
        )
        
        // When
        let viewModelPosterImageURL = viewModelToTest.posterImageURL
        
        // Then
        XCTAssertNotNil(posterPlaceholder)
        XCTAssertEqual(posterPlaceholder, viewModelPosterImageURL)
    }
    
    // MARK: - Title
    func test_topRatedMoviesCell_title() {
        // Given
        let titleToTest = "The Godfather"
        let viewModelToTest = createSUT(
            with: Movie.fixture(title: titleToTest)
        )
        
        // When
        let viewModelTitle = viewModelToTest.title
        
        // Then
        XCTAssertNotNil(titleToTest)
        XCTAssertEqual(titleToTest, viewModelTitle)
    }
    
    // MARK: - Subtitle
    func test_topRatedMoviesCell_subtitle_createdBasedOnGenreIds_and_notNil() {
        // Given
        let genresWithIDs = [
            "Adventure": 12,
            "Animation": 16,
            "Action": 28
        ]
        let viewModelToTest = createSUT(
            with: Movie.fixture(genreIds: Array(genresWithIDs.values))
        )
        let genreNames = Array(genresWithIDs.keys).joined(separator: ", ")
        
        // When
        let viewModelSubtitle = viewModelToTest.subtitle
        
        // Then
        XCTAssertNotNil(genresWithIDs)
        XCTAssertNotNil(genreNames)
        XCTAssertEqual(genreNames, viewModelSubtitle)
    }
    
    func test_topRatedMoviesCell_subtitle_whenGenresIsNil_or_doesntExist() {
        // Given
        let viewModelToTest = createSUT(
            with: Movie.fixture(genreIds: nil)
        )
        
        // When
        let viewModelSubtitle = viewModelToTest.subtitle
        
        // Then
        XCTAssertEqual(Constants.notAvailable, viewModelSubtitle)
    }
    
    // MARK: - Rating
    func test_topRatedMoviesCell_rating() {
        // Given
        let ratingToTest = 8.7
        let viewModelToTest = createSUT(
            with: Movie.fixture(voteAverage: ratingToTest)
        )
        let stringConvertedRatingToTest = String(ratingToTest)
        
        // When
        let viewModelRating = viewModelToTest.rating
        
        // Then
        XCTAssertNotNil(ratingToTest)
        XCTAssertNotNil(stringConvertedRatingToTest)
        XCTAssertEqual(stringConvertedRatingToTest, viewModelRating)
    }
}

// MARK: - Create SUT Helper
extension TopRatedMoviesCellViewModelTests {
    private func createSUT(with movie: Movie) -> TopRatedMoviesCellViewModel {
        return TopRatedMoviesCellViewModel(movie: movie)
    }
}
