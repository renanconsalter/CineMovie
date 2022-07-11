//
//  MovieGenres.swift
//  CineMovie
//
//  Created by Renan Consalter on 29/06/22.
//

import Foundation

struct MovieGenre: Decodable {
    let id: Int
    let name: String
}

enum MovieGenres: Int, CaseIterable {
    case action = 28
    case adventure = 12
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case fantasy = 14
    case history = 36
    case horror = 27
    case music = 10402
    case mystery = 9648
    case romance = 10749
    case scienceFiction = 878
    case tvMovie = 10770
    case thriller = 53
    case war = 10752
    case western = 37

    var description: String {
        switch self {
            case .action: return "Action"
            case .adventure: return "Adventure"
            case .animation: return "Animation"
            case .comedy: return "Comedy"
            case .crime: return "Crime"
            case .documentary: return "Documentary"
            case .drama: return "Drama"
            case .family: return "Family"
            case .fantasy: return "Fantasy"
            case .history: return "History"
            case .horror: return "Horror"
            case .music: return "Music"
            case .mystery: return "Mystery"
            case .romance: return "Romance"
            case .scienceFiction: return "Science Fiction"
            case .tvMovie: return "TV Movie"
            case .thriller: return "Thriller"
            case .war: return "War"
            case .western: return "Western"
        }
    }
}
