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
    var favorite: Bool = false
    let stats: [Stat]?
 
    var mainType: PokemonType? {
        return self.types.first
    }
    
    var strongestStat: Stat? {
        return stats?.max { $0.value < $1.value }
    }
}
