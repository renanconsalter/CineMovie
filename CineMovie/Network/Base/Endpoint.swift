//
//  Endpoint.swift
//  CineMovie
//
//  Created by Renan Consalter on 28/06/22.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var body: [String : String]? { get }
    var method: HttpMethod { get }
    var queryParams: [String: Any]? { get }
}

extension Endpoint {
    
    // The Movies Database API
    // Docs: https://developers.themoviedb.org/3/getting-started/introduction
    
    var completeUrl: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = "/3" + path
        urlComponents.queryItems = queryParams?.compactMap {
            URLQueryItem(name: $0.key, value: "\($0.value)")
        }
        
        return urlComponents.url
    }
    
    var header: [String: String]? {
        let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZTYzMTcxYWE0N2ZkODAyMjM3NjA0NzI3OThkNzJkZSIsInN1YiI6IjYyYmIyZTE3MmUyYjJjMDMxZDI1MWM0YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.C-yhi7sM5Vi3SjQqYGVJJK4gly6UFfh22RPmswjxM6w"
        
        return [
            "Authorization": "Bearer \(apiKey)"
        ]
    }
}
