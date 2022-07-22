//
//  TopRatedMoviesCellViewModel.swift
//  CineMovie
//
//  Created by Renan Consalter on 30/06/22.
//

import Foundation

final class TopRatedMoviesCellViewModel {
    
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var posterImageURL: String {
        guard let posterPath = movie.posterPath else {
            return Constants.ApiImageURL.posterPlaceholder
        }
        return Constants.ApiImageURL.lowQuality + posterPath
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
        return "\(movie.voteAverage)"
    }
}
