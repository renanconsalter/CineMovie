//
//  HTTPClient.swift
//  CineMovie
//
//  Created by Renan Consalter on 28/06/22.
//

import Foundation

protocol HTTPClientProtocol {
    func request<T: Decodable>(endpoint: Endpoint,
                               model: T.Type,
                               completion: @escaping (Result<T, ErrorHandler>) -> Void)
}

final class HTTPClient: HTTPClientProtocol {
    
    static let shared = HTTPClient()
    
    func request<T>(endpoint: Endpoint,
                    model: T.Type,
                    completion: @escaping (Result<T, ErrorHandler>) -> Void)
                    where T : Decodable {

        guard let url = endpoint.completeURL else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = endpoint.header
        request.httpMethod = endpoint.method.rawValue
        request.timeoutInterval = endpoint.timeout
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            switch response.statusCode {
            case 200...299:
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decode))
                }
            case 400:
                completion(.failure(.badRequest))
                return
            case 401:
                completion(.failure(.unauthorized))
                return
            case 404:
                completion(.failure(.notFound))
                return
            case 500:
                completion(.failure(.serverError))
                return
            default:
                completion(.failure(.unexpectedStatusCode))
                return
            }
            
        }.resume()
    }
}
