//
//  PopularMoviesCellViewModel.swift
//  CineMovie
//
//  Created by Renan Consalter on 28/06/22.
//

import Foundation

final class PopularMoviesCellViewModel {
    
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var posterImageURL: String {
        guard let posterPath = movie.posterPath else {
            return Constants.ApiImageURL.posterPlaceholder
        }
        return Constants.ApiImageURL.mediumQuality + posterPath
    }
}
