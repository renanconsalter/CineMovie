//
//  MoviesEndpoint.swift
//  CineMovie
//
//  Created by Renan Consalter on 28/06/22.
//

import Foundation

enum MoviesEndpoint {
    case getTopRatedMovies(page: Int)
    case getPopularMovies(page: Int)
    case searchMovie(query: String)
    case getMovieById(id: Int)
}

extension MoviesEndpoint: Endpoint {
    var body: [String : String]? {
        switch self {
        case  .getTopRatedMovies,
              .getPopularMovies,
              .searchMovie,
              .getMovieById:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .getTopRatedMovies:
            return "/movie/top_rated"
        case .getPopularMovies:
            return "/movie/popular"
        case .searchMovie:
            return "/search/movie"
        case .getMovieById(let id):
            return "/movie/\(id)"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .getTopRatedMovies,
             .getPopularMovies,
             .searchMovie,
             .getMovieById:
            return .get
        }
    }
    
    var queryParams: [String: Any]? {
        switch self {
        case .getTopRatedMovies(let page),
             .getPopularMovies(let page):
            return [
                "page": page
            ]
        case .searchMovie(let query):
            return [
                "query": query
            ]
        case .getMovieById:
            return nil
        }
    }
}
