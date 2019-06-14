//
//  Pokemon.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 08/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    
    let id: Int
    let name: String
    let image: String
    let types: [PokemonType]
    let description: String?
    let stats: [Stat]?
    
}
