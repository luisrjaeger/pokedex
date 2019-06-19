//
//  File.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 13/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

enum StatName: String, Codable {
    
    case hp = "hp"
    case spd = "speed"
    case sdef = "special-defense"
    case satk = "special-attack"
    case def = "defense"
    case atk = "attack"
    
    var shortName: String {
        switch self {
        case .hp:
            return "hp"
        case .spd:
            return "spd"
        case .sdef:
            return "sdef"
        case .satk:
            return "satk"
        case .def:
            return "def"
        case .atk:
            return "atk"
        }
    }
    
}
