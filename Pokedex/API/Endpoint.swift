//
//  Endpoint.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 19/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

extension RequestMaker {
    
    enum Endpoint {
        
        case pokemons
        case pokemon(query: String)
        case moves
        case move(query: String)
        case items
        case favorites
        
        var baseUrl: String {
            switch self {
            case .move:
                return "https://pokeapi.co/api/v2/"
            default:
                return "https://pokemon-mock.herokuapp.com/api/"
            }
        }
        
        var url: String {
            switch self {
            case .pokemons:
                return "pokemon"
            case let .pokemon(query):
                return "pokemon/\(query)"
            case .moves:
                return "move"
            case let .move(query):
                return "move/\(query)"
            case .items:
                return "item"
            case .favorites:
                return "pokemon/favorite"
            }
        }
        
    }
    
}
