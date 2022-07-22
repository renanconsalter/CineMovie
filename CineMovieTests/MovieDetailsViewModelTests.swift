//
//  MovieDetailsViewModelTests.swift
//  CineMovieTests
//
//  Created by Renan Consalter on 22/07/22.
//

import XCTest

@testable import CineMovie

final class MovieDetailsViewModelTests: XCTestCase {
    // MARK: - id
    func test_movieDetails_isValid_and_notNil() {
        // Given
        let idToTest: Int = 25
        let viewModelToTest = createSUT(
            with: Movie.fixture(id: idToTest)
        )
        
        // When
        let viewModelMovieId = viewModelToTest.id
        
        // Then
        XCTAssertNotNil(idToTest)
        XCTAssertEqual(idToTest, viewModelMovieId)
    }
    
    // MARK: - Backdrop Image
    func test_movieDetails_whenBackdropImagePathIsValid_and_notNil() {
        // Given
        let backdropImagePathBaseURL = Constants.ApiImageURL.highQuality
        let backdropPathToTest: String = "/backdrop.jpg"
        let viewModelToTest = createSUT(
            with: Movie.fixture(backdropPath: backdropPathToTest)
        )
        
        // When
        let viewModelPosterImageURL = viewModelToTest.backdropImageURL
        let completeBackdropImageURL = backdropImagePathBaseURL + backdropPathToTest
        
        // Then
        XCTAssertNotNil(backdropPathToTest)
        XCTAssertNotNil(backdropImagePathBaseURL)
        XCTAssertNotNil(completeBackdropImageURL)
        
        XCTAssertEqual(completeBackdropImageURL, viewModelPosterImageURL)
    }
    
    func test_movieDetails_whenBackdropImagePathIsNil_or_doesntExist_shouldReturnPlaceholder() {
        // Given
        let backdropPlaceholder = Constants.ApiImageURL.backdropPlaceholder
        let viewModelToTest = createSUT(
            with: Movie.fixture(backdropPath: nil)
        )
        
        // When
        let viewModelBackdropImageURL = viewModelToTest.backdropImageURL
        
        // Then
        XCTAssertNotNil(backdropPlaceholder)
        XCTAssertEqual(backdropPlaceholder, viewModelBackdropImageURL)
    }
    
    // MARK: - Title
    func test_movieDetails_title_isNotNil() {
        // Given
        let titleToTest: String = "The Godfather"
        let viewModelToTest = createSUT(
            with: Movie.fixture(title: titleToTest)
        )
        
        // When
        let viewModelTitle = viewModelToTest.title
        
        // Then
        XCTAssertNotNil(titleToTest)
        XCTAssertEqual(titleToTest, viewModelTitle)
    }
    
    // MARK: - Primary Genre
    func test_movieDetails_primaryGenre_notNil() {
        // Given
        let genresToTest: [MovieGenre] = [
            MovieGenre(id: MovieGenres.action.rawValue, name: "Action"),
            MovieGenre(id: MovieGenres.comedy.rawValue, name: "Comedy")
        ]
        let primaryGenreToTest = genresToTest.first!.name
        let viewModelToTest = createSUT(
            with: Movie.fixture(genres: genresToTest)
        )
        
        // When
        let viewModelPrimaryGenre = viewModelToTest.primaryGenre
        
        // Then
        XCTAssertNotNil(genresToTest)
        XCTAssertNotNil(primaryGenreToTest)
        XCTAssertEqual(primaryGenreToTest, viewModelPrimaryGenre)
    }
    
    func test_movieDetails_primaryGenre_isNil_or_doesntExist() {
        let viewModelToTest = createSUT(
            with: Movie.fixture(genres: nil)
        )
        
        let viewModelPrimaryGenre = viewModelToTest.primaryGenre
        
        XCTAssertEqual(Constants.notAvailable, viewModelPrimaryGenre)
    }
    
    // MARK: - Subtitle
    func test_movieDetails_subtitle_whenRuntimeIsNil_or_doesntExist() {
        // Given
        let viewModelToTest = createSUT(
            with: Movie.fixture(runtime: nil)
        )
        
        // When
        let viewModelSubtitle = viewModelToTest.subtitle
        
        // Then
        XCTAssertEqual(Constants.notAvailable, viewModelSubtitle)
    }
    
    func test_movieDetails_subtitle_whenReleaseDateIsInvalid_or_doesntExist() {
        // Given
        let releaseDateToTest = "11/12/2020"
        let viewModelToTest = createSUT(
            with: Movie.fixture(releaseDate: releaseDateToTest)
        )
        
        // When
        let releaseYear = viewModelToTest.getYearComponentOfDate(date: releaseDateToTest)
        let viewModelSubtitle = viewModelToTest.subtitle
        
        // Then
        XCTAssertNil(releaseYear)
        XCTAssertEqual(Constants.notAvailable, viewModelSubtitle)
    }
    
    func test_movieDetails_subtitle_whenRuntimeAndReleaseDate_isNotNil() {
        // Given
        let runtimeToTest: Int = 185
        let releaseDateToTest: String = "2022/01/01"
        let genresToTest: [MovieGenre] = [
            MovieGenre(id: MovieGenres.action.rawValue, name: "Action"),
            MovieGenre(id: MovieGenres.comedy.rawValue, name: "Comedy")
        ]
        let viewModelToTest = createSUT(
            with: Movie.fixture(genres: genresToTest,
                                releaseDate: releaseDateToTest,
                                runtime: runtimeToTest)
        )
        
        // When
        let primaryGenre = genresToTest.first!.name
        let releaseYear = viewModelToTest.getYearComponentOfDate(date: releaseDateToTest)!
        let duration = viewModelToTest.convertMinutesToHoursAndMinutes(runtime: runtimeToTest)!
        let formattedSubtitle = "\(primaryGenre) • \(releaseYear) • \(duration)"
        
        let viewModelSubtitle = viewModelToTest.subtitle
        
        // Then
        XCTAssertNotNil(primaryGenre)
        XCTAssertNotNil(releaseYear)
        XCTAssertNotNil(duration)
        XCTAssertNotNil(formattedSubtitle)
        
        XCTAssertEqual(formattedSubtitle, viewModelSubtitle)
    }
    
    // MARK: - Overview
    func test_movieDetails_overview_isNotNil() {
        // Given
        let overviewToTest: String = "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge."
        let viewModelToTest = createSUT(
            with: Movie.fixture(overview: overviewToTest)
        )
        
        // When
        let viewModelOverview = viewModelToTest.overview
        
        // Then
        XCTAssertNotNil(overviewToTest)
        XCTAssertNotNil(viewModelOverview)
        
        XCTAssertEqual(overviewToTest, viewModelOverview)
    }
    
    // MARK: - Rating Stars
    func test_movieDetails_ratingStars_isNotNil() {
        // Given
        let ratingToTest: Double = 9.2
        let ratingStarsToTest: String = "★★★★★★★★★" // 9 stars
        let viewModelToTest = createSUT(
            with: Movie.fixture(voteAverage: ratingToTest)
        )
        
        // When
        let viewModelRatingStars = viewModelToTest.ratingStars
        
        
        // Then
        XCTAssertNotNil(ratingToTest)
        XCTAssertNotNil(ratingStarsToTest)
        XCTAssertNotNil(viewModelRatingStars)
        
        XCTAssertEqual(ratingStarsToTest, viewModelRatingStars)
    }
    
    // MARK: - Score
    func test_movieDetails_score_isNotNil_and_moreThanZero() {
        // Given
        let scoreToTest: Double = 9.256
        let viewModelToTest = createSUT(
            with: Movie.fixture(voteAverage: scoreToTest)
        )
        
        // When
        let formattedScore = String(format: "%.1f", scoreToTest) + "/10"
        let viewModelScore = viewModelToTest.score
        
        // Then
        XCTAssertNotNil(scoreToTest)
        XCTAssertNotNil(formattedScore)
        XCTAssertNotNil(viewModelScore)
        
        XCTAssertEqual(formattedScore, viewModelScore)
    }
    
    func test_movieDetails_score_isZero() {
        // Given
        let scoreToTest: Double = 0.0
        let viewModelToTest = createSUT(
            with: Movie.fixture(voteAverage: scoreToTest)
        )
        
        // When
        let viewModelScore = viewModelToTest.score
        
        // Then
        XCTAssertEqual(Constants.notAvailable, viewModelScore)
    }
}

// MARK: - Create SUT Helper
extension MovieDetailsViewModelTests {
    private func createSUT(with movie: Movie) -> MovieDetailsViewModel {
        return MovieDetailsViewModel(movie: movie)
    }
}
