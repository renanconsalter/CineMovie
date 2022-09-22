//
//  TopRatedMoviesCellViewModel.swift
//  CineMovie
//
//  Created by Renan Consalter on 30/06/22.
//

import Foundation

struct TopRatedMoviesCellViewModel {
    // MARK: Properties

    private let movie: Movie

    // MARK: Initialization

    init(movie: Movie) {
        self.movie = movie
    }

    // MARK: Presentation Properties

    var posterImageURL: String {
        guard let posterPath = movie.posterPath else {
            return Constants.ImageURL.posterPlaceholder
        }
        return Constants.ImageURL.lowQuality + posterPath
    }

    var title: String {
        return movie.title
    }

    var subtitle: String {
        guard let genreIds = movie.genreIds else {
            return Constants.notAvailable
        }

        let genreNames = genreIds.compactMap {
            MovieGenres(rawValue: $0)?.description
        }

        return genreNames.joined(separator: ", ")
    }

    var rating: String {
        return String(movie.voteAverage)
    }
}
