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
    
    var imageURL: URL? {
        return movie.posterURL
    }
}
