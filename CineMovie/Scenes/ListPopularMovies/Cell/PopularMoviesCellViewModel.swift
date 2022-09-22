//
//  PopularMoviesCellViewModel.swift
//  CineMovie
//
//  Created by Renan Consalter on 28/06/22.
//

import Foundation

struct PopularMoviesCellViewModel {
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
        return Constants.ImageURL.mediumQuality + posterPath
    }
}
