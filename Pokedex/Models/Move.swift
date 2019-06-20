//
//  Move.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 08/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

struct Move: Codable {
    
    let name: String
    let type: PokemonType

}

struct MoveDetail: Codable {
    
    let accuracy: Int?
    let contestEffect: ContestEffect
    let effectChance: Int?
    let effectEntries: [EffectEntry]
    let id: Int
    let name: String
    let power, pp, priority: Int?
    let type: ContestType
    
    enum CodingKeys: String, CodingKey {
        case accuracy
        case contestEffect = "contest_effect"
        case effectChance = "effect_chance"
        case effectEntries = "effect_entries"
        case power, pp, priority
        case type, id, name
    }
}

struct ContestType: Codable {
    let name: PokemonType
    let url: String
}

struct ContestEffect: Codable {
    let url: String
}

struct EffectEntry: Codable {
    let effect: String
    let language: ContestTarget
    let shortEffect: String
    
    enum CodingKeys: String, CodingKey {
        case effect, language
        case shortEffect = "short_effect"
    }
}

struct ContestTarget: Codable {
    let name: String
    let url: String
}

struct StatChange: Codable {
    let change: Int
    let stat: ContestTarget
}
