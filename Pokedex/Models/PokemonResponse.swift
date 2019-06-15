//
//  PokemonResponse.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 15/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

struct PokemonResponse: Codable {
    
    let list: PokemonList
    let details: [Pokemon]
    
}
