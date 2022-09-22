//
//  Constants.swift
//  CineMovie
//
//  Created by Renan Consalter on 07/07/22.
//

import Foundation

enum Constants {
    static let notAvailable = "N/A"

    enum Colors {
        static let starYellow = "AccentColor"
    }
    enum Icons {
        static let star = "star"
        static let starFill = "star.fill"
        static let film = "film"
        static let filmFill = "film.fill"
        static let search = "magnifyingglass"
        static let searchTextFill = "text.magnifyingglass"
        static let close = "xmark"
        static let appLogo = "Logo"
    }
    enum Images {
        static let posterPlaceholder = "PosterPlaceholder"
        static let backdropPlaceholder = "BackdropPlaceholder"
        static let noResults = "NoResults"
    }
    enum Menus {
        static let topRated = "Top Rated"
        static let popular = "Popular"
        static let search = "Search"
    }
    enum Search {
        static let emptyStateWelcomeText = "Welcome! Type a movie name to start."
        static let emptyStateNoResultsText = "Sorry! We couldn't find any results."
        static let placeholder = "Search movies"
    }
    enum Alerts {
        static let defaultTitle = "Oops"
        static let defaultButtonText = "OK"
        static let tryAgainButtonText = "Try Again"
    }
    enum Identifiers {
        static let searchMoviesTableViewIdentifier = "SearchMoviesTableViewCell"
        static let popularMoviesCollectionFooterIdentifier = "popularMoviesCollectionFooterIdentifier"
    }
    enum ImageURL {
        static let highQuality = "https://image.tmdb.org/t/p/w780"
        static let mediumQuality = "https://image.tmdb.org/t/p/w342"
        static let lowQuality = "https://image.tmdb.org/t/p/w154"
        static let posterPlaceholder = "https://critics.io/img/movies/poster-placeholder.png"
        static let backdropPlaceholder = "https://image.xumo.com/v1/assets/asset/XM05YG2LULFZON/600x340.jpg"
    }
}
