//
//  TopRatedMoviesEndpoint.swift
//  CineMovie
//
//  Created by Renan Consalter on 22/08/22.
//

import Foundation

enum TopRatedMoviesEndpoint {
    case getTopRatedMovies(page: Int)
}

extension TopRatedMoviesEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getTopRatedMovies:
            return "/movie/top_rated"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getTopRatedMovies:
            return .get
        }
    }

    var queryParams: [URLQueryItem] {
        switch self {
        case .getTopRatedMovies(let page):
            return [
                URLQueryItem(name: "page", value: "\(page)")
            ]
        }
    }
}
