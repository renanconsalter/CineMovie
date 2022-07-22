//
//  MoviesService.swift
//  CineMovie
//
//  Created by Renan Consalter on 28/06/22.
//

import Foundation

protocol MoviesServiceProtocol {
    typealias ResultMovies = (Result<MoviesResponse, ErrorHandler>)
    
    func getTopRatedMovies(page: Int, completion: @escaping (ResultMovies) -> Void)
    func getPopularMovies(page: Int, completion: @escaping (ResultMovies) -> Void)
    func searchMovie(query: String, completion: @escaping (ResultMovies) -> Void)
    func getMovie(id: Int, completion: @escaping (Result<Movie, ErrorHandler>) -> Void)
}

final class MoviesService: MoviesServiceProtocol {
    
    static let shared = MoviesService()
    
    private let httpClient: HttpClientProtocol
    
    init(httpClient: HttpClientProtocol = HttpClient.shared) {
        self.httpClient = httpClient
    }
    
    func getTopRatedMovies(page: Int, completion: @escaping (ResultMovies) -> Void) {
        httpClient.request(endpoint: MoviesEndpoint.getTopRatedMovies(page: page),
                           model: MoviesResponse.self,
                           completion: completion)
    }
    
    func getPopularMovies(page: Int, completion: @escaping (ResultMovies) -> Void) {
        httpClient.request(endpoint: MoviesEndpoint.getPopularMovies(page: page),
                           model: MoviesResponse.self,
                           completion: completion)
    }
    
    func searchMovie(query: String, completion: @escaping (ResultMovies) -> Void) {
        httpClient.request(endpoint: MoviesEndpoint.searchMovie(query: query),
                           model: MoviesResponse.self,
                           completion: completion)
    }
    
    func getMovie(id: Int, completion: @escaping (Result<Movie, ErrorHandler>) -> Void) {
        httpClient.request(endpoint: MoviesEndpoint.getMovieById(id: id),
                           model: Movie.self,
                           completion: completion)
    }
}
