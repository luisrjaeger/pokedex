//
//  RequestMaker.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 08/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

class RequestMaker {
    
    static let decoder = JSONDecoder()
    
    enum Endpoint {
        
        case list
        case details(query: String)
        case moves
        case move(query: String)
        
        var baseUrl: String {
            switch self {
            case .move:
                return "https://pokeapi.co/api/v2/"
            default:
                return "http://localhost:3000/"
            }
        }
        
        var url: String {
            switch self {
            case .list:
                return "list"
            case let .details(query):
                return "details/\(query)"
            case .moves:
                return "moves"
            case let .move(query):
                return "move/\(query)"
            }
        }
        
    }

    let session = URLSession.shared
    
    typealias CompletionCallback<T: Decodable> = (RequestResult<T>) -> Void
    typealias RequestResult<T> = Result<T, RequestMakerError>
    typealias SuccessCallback<T: Decodable> = (T) -> Void
    
    
    func make<T: Decodable>(withEndpoint endpoint: Endpoint, completion: @escaping SuccessCallback<T>) {
        return make(withEndpoint: endpoint, completion: { (result: RequestResult<T>) in
            switch result {
            case .success(let object):
                completion(object)
            case .failure:
                break
            }
        })
    }
    
    func make<T: Decodable>(withEndpoint endpoint: Endpoint, completion: @escaping CompletionCallback<T>) {
        guard let url = URL(string: "\(endpoint.baseUrl)\(endpoint.url)") else {
            completion(.failure(.malformedURL))
            return
        }
        
        let dataTask = session.dataTask(with: url) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            guard error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decodedObject = try RequestMaker.decoder.decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch _ {
                completion(.failure(.decodingFailed))
            }
        }
        
        dataTask.resume()
    }

}

enum RequestMakerError: Error {
    
    case malformedURL
    case requestFailed
    case invalidData
    case decodingFailed
    
}
