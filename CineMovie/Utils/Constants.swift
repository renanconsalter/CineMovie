//
//  Constants.swift
//  CineMovie
//
//  Created by Renan Consalter on 07/07/22.
//

import Foundation

struct Constants {
    
    static let notAvailable = "N/A"
    
    struct Colors {
        static let starYellow = "AccentColor"
    }
    struct Icons {
        static let star = "star"
        static let starFill = "star.fill"
        static let film = "film"
        static let filmFill = "film.fill"
        static let search = "magnifyingglass"
        static let close = "xmark"
        static let appLogo = "Logo"
    }
    struct Menus {
        static let topRated = "Top Rated"
        static let popular = "Popular"
        static let search = "Search"
    }
    struct Search {
        static let emptyStateWelcomeText = "Welcome! Type a movie name to start."
        static let emptyStateNoResultsText = "Sorry! We couldn't find any results."
        static let placeholder = "Search movies"
        static let noResultsImage = "NoResults"
    }
    struct Alerts {
        static let defaultTitle = "Oops"
        static let defaultButtonTitle = "OK"
        static let tryAgainButtonTitle = "Try Again"
    }
    struct Identifiers {
        static let searchMoviesTableViewIdentifier = "SearchMoviesTableViewCell"
    }
    struct ApiImageURL {
        static let highQuality = "https://image.tmdb.org/t/p/w780"
        static let mediumQuality = "https://image.tmdb.org/t/p/w342"
        static let lowQuality = "https://image.tmdb.org/t/p/w154"
    }
}
