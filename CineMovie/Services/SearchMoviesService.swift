//
//  SearchMoviesService.swift
//  CineMovie
//
//  Created by Renan Consalter on 30/08/22.
//

import Foundation

protocol SearchMoviesServiceProtocol {
    func searchMovie(query: String, completion: @escaping (Result<MoviesResponse, ErrorHandler>) -> Void)
}

final class SearchMoviesService: SearchMoviesServiceProtocol {
    
    private let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol = HTTPClient.shared) {
        self.httpClient = httpClient
    }

    func searchMovie(query: String, completion: @escaping (Result<MoviesResponse, ErrorHandler>) -> Void) {
        httpClient.request(endpoint: SearchMoviesEndpoint.searchMovie(query: query),
                           model: MoviesResponse.self,
                           completion: completion)
    }
}
