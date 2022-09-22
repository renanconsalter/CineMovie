//
//  Endpoint.swift
//  CineMovie
//
//  Created by Renan Consalter on 28/06/22.
//

// --------------------------------------------------------------
// ----------------------- IMPORTANT NOTE -----------------------
// --------------------------------------------------------------
//
// If you got a '401: No authorization' or fatal error trying to run the application, please check this section:
//
// The API needs a personal Bearer Token to access its content.
// The token will be used on a Authorization HTTP header.
//
// To make it work correctly, follow these steps:
// 1 - Open "TMDB-Auth-Info.plist" file in the target root directory.
// 2 - On the "TMDB_API_KEY" value field, paste a valid secret key (v4 auth) generated by TMDB API.
//
// For more information about how to generate your secret key, check this link:
// https://developers.themoviedb.org/3/getting-started/introduction

import Foundation

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
        let apiKey = getAuthInfoFromPropertyList()

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

private func getAuthInfoFromPropertyList() -> String {
    let fileName = "TMDB-Auth-Info"
    let propertyKey = "TMDB_API_KEY"

    guard let filePath = Bundle.main.path(forResource: fileName, ofType: "plist") else {
        fatalError("Couldn't find file '\(fileName).plist' on target root directory.")
    }
    guard let value = NSDictionary(contentsOfFile: filePath)?.object(forKey: propertyKey) as? String else {
        fatalError("Couldn't find key '\(propertyKey)' in '\(fileName).plist'.")
    }

    return value
}
