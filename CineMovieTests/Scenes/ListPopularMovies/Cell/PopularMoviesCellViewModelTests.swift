//
//  PopularMoviesCellViewModelTests.swift
//  CineMovieTests
//
//  Created by Renan Consalter on 22/07/22.
//

import XCTest

@testable import CineMovie

final class PopularMoviesCellViewModelTests: XCTestCase {
    // MARK: PosterPath Image

    func test_popularMoviesCell_whenPosterPathIsValid_and_notNil() {
        // Given
        let posterImagePathBaseURL = Constants.ImageURL.mediumQuality
        let posterPathToTest = "/posterImage.jpg"
        let viewModelToTest = createSUT(
            with: Movie.fixture(posterPath: posterPathToTest)
        )

        // When
        let viewModelPosterImageURL = viewModelToTest.posterImageURL
        let completePosterImageURL = posterImagePathBaseURL + posterPathToTest

        // Then
        XCTAssertNotNil(posterPathToTest)
        XCTAssertNotNil(posterImagePathBaseURL)

        XCTAssertEqual(completePosterImageURL, viewModelPosterImageURL)
    }

    func test_popularMoviesCell_whenPosterPathIsNil_or_doesntExist_shouldReturnPlaceholder() {
        // Given
        let posterPlaceholder = Constants.ImageURL.posterPlaceholder
        let viewModelToTest = createSUT(
            with: Movie.fixture(posterPath: nil)
        )

        // When
        let viewModelPosterImageURL = viewModelToTest.posterImageURL

        // Then
        XCTAssertNotNil(posterPlaceholder)
        XCTAssertEqual(posterPlaceholder, viewModelPosterImageURL)
    }
}

// MARK: Create SUT Helper

extension PopularMoviesCellViewModelTests {
    private func createSUT(with movie: Movie) -> PopularMoviesCellViewModel {
        return PopularMoviesCellViewModel(movie: movie)
    }
}
