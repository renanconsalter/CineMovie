//
//  TopRatedMoviesService.swift
//  CineMovie
//
//  Created by Renan Consalter on 29/08/22.
//

import Foundation

protocol TopRatedMoviesServiceProtocol {
    func getTopRatedMovies(page: Int, completion: @escaping (Result<MoviesResponse, ErrorHandler>) -> Void)
}

final class TopRatedMoviesService: TopRatedMoviesServiceProtocol {
    
    private let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol = HTTPClient.shared) {
        self.httpClient = httpClient
    }
    
    func getTopRatedMovies(page: Int, completion: @escaping (Result<MoviesResponse, ErrorHandler>) -> Void) {
        httpClient.request(endpoint: TopRatedMoviesEndpoint.getTopRatedMovies(page: page),
                           model: MoviesResponse.self,
                           completion: completion)
    }
}
