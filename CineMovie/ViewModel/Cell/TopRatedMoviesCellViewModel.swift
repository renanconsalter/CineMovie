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
    
    var imageURL: String {
        return movie.posterURL
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
