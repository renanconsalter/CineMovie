//
//  PopularMoviesService.swift
//  CineMovie
//
//  Created by Renan Consalter on 30/08/22.
//

import Foundation

protocol PopularMoviesServiceProtocol {
    func getPopularMovies(page: Int, completion: @escaping (Result<MoviesResponse, ErrorHandler>) -> Void)
}

final class PopularMoviesService: PopularMoviesServiceProtocol {
    private let httpClient: HTTPClientProtocol

    init(httpClient: HTTPClientProtocol = HTTPClient.shared) {
        self.httpClient = httpClient
    }

    func getPopularMovies(page: Int, completion: @escaping (Result<MoviesResponse, ErrorHandler>) -> Void) {
        httpClient.request(
            endpoint: PopularMoviesEndpoint.getPopularMovies(page: page),
            model: MoviesResponse.self,
            completion: completion
        )
    }
}
