//
//  Movie.swift
//  CineMovie
//
//  Created by Renan Consalter on 28/06/22.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let genres: [MovieGenre]?
    let genreIds: [Int]?
    let overview: String
    let releaseDate: String?
    let runtime: Int?
    let voteAverage: Double
    
    private let backdropPath: String?
    private let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case genres
        case genreIds = "genre_ids"
        case overview
        case releaseDate = "release_date"
        case runtime
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
    }
}

extension Movie {
    var backdropURL: URL? {
        guard let backdropPath = self.backdropPath else {
            return URL(string: "https://image.xumo.com/v1/assets/asset/XM05YG2LULFZON/600x340.jpg")
        }
        return URL(string: "\(Constants.ApiImageURL.highQuality)\(backdropPath)")
    }
    
    var posterURL: URL? {
        guard let posterPath = self.posterPath else {
            return URL(string: "https://critics.io/img/movies/poster-placeholder.png")
        }
        return URL(string: "\(Constants.ApiImageURL.mediumQuality)\(posterPath)")
    }
}
