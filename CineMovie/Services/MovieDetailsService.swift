//
//  MovieDetailsService.swift
//  CineMovie
//
//  Created by Renan Consalter on 30/08/22.
//

import Foundation

protocol MovieDetailsServiceProtocol {
    func getMovie(id: Int, completion: @escaping (Result<Movie, ErrorHandler>) -> Void)
}

final class MovieDetailsService: MovieDetailsServiceProtocol {
    private let httpClient: HTTPClientProtocol

    init(httpClient: HTTPClientProtocol = HTTPClient.shared) {
        self.httpClient = httpClient
    }

    func getMovie(id: Int, completion: @escaping (Result<Movie, ErrorHandler>) -> Void) {
        httpClient.request(
            endpoint: MovieDetailsEndpoint.getMovie(id: id),
            model: Movie.self,
            completion: completion
        )
    }
}
