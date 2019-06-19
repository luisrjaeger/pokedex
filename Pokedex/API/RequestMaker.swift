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
    static let encoder = JSONEncoder()
    
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
    
    func make<E: Encodable, D: Decodable>(withEndpoint endpoint: Endpoint, sending data: E, completion: @escaping SuccessCallback<D>) {
        return make(withEndpoint: endpoint, sending: data, completion: { (result: RequestResult<D>) in
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
            self.handleDataTaskResult(data: data, response: response, error: error, completion: completion)
        }
        
        dataTask.resume()
    }
    
    func make<E: Encodable, D: Decodable>(withEndpoint endpoint: Endpoint, sending data: E, completion: @escaping CompletionCallback<D>) {
        guard let jsonData = try? RequestMaker.encoder.encode(data) else {
            completion(.failure(.encodingFailed))
            return
        }
        
        guard let url = URL(string: "\(endpoint.baseUrl)\(endpoint.url)") else {
            completion(.failure(.malformedURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = session.dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) in
            self.handleDataTaskResult(data: data, response: response, error: error, completion: completion)
        }
        
        dataTask.resume()
    }
    
    func handleDataTaskResult<D: Decodable>(data: Data?, response: URLResponse?, error: Error?, completion: @escaping CompletionCallback<D>) {
        guard error == nil else {
            completion(.failure(.requestFailed))
            return
        }
        
        guard let data = data else {
            completion(.failure(.invalidData))
            return
        }
        do {
            let decodedObject = try RequestMaker.decoder.decode(D.self, from: data)
            completion(.success(decodedObject))
        } catch _ {
            completion(.failure(.decodingFailed))
        }
    }
    
}

enum RequestMakerError: Error {
    
    case malformedURL
    case requestFailed
    case invalidData
    case encodingFailed
    case decodingFailed
    
}
