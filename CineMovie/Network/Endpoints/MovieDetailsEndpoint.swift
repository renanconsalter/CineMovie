//
//  MovieDetailsEndpoint.swift
//  CineMovie
//
//  Created by Renan Consalter on 22/08/22.
//

import Foundation

enum MovieDetailsEndpoint {
    case getMovie(id: Int)
}

extension MovieDetailsEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getMovie(let id):
            return "/movie/\(id)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getMovie:
            return .get
        }
    }
}
