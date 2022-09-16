//
//  Endpoint.swift
//  CineMovie
//
//  Created by Renan Consalter on 28/06/22.
//

import Foundation

// The Movies Database API
// Documentation: https://developers.themoviedb.org/3/getting-started/introduction

protocol Endpoint {
    var path: String { get }
    var body: [String: Any]? { get }
    var header: [String: String] { get }
    var method: HTTPMethod { get }
    var queryParams: [URLQueryItem] { get }
    var timeout: TimeInterval { get }
    var completeURL: URL? { get }
}

extension Endpoint {
    var body: [String: Any]? {
        return nil
    }

    var header: [String: String] {
        let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZTYzMTcxYWE0N2ZkODAyMjM3NjA0NzI3OThkNzJkZSIsInN1YiI6IjYyYmIyZTE3MmUyYjJjMDMxZDI1MWM0YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.C-yhi7sM5Vi3SjQqYGVJJK4gly6UFfh22RPmswjxM6w"
        
        return [
            "Authorization": "Bearer \(apiKey)"
        ]
    }
    
    var queryParams: [URLQueryItem] {
        return []
    }
    
    var timeout: TimeInterval {
        return 30
    }
    
    var completeURL: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = "/3" + path
        urlComponents.queryItems = queryParams
        
        return urlComponents.url
    }
}
