//
//  PokemonInteractor.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 17/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

class PokemonInteractor: PokemonInteractorInput {
    
    private let requestMaker = RequestMaker()
    
    weak var output: PokemonInteractorOutput!
    
    init(output: PokemonInteractorOutput) {
        self.output = output
    }
    
    func fetchData(pokemonId: Int) {
        requestMaker.make(withEndpoint: .pokemon(query: String(pokemonId))) {
            (pokemon: Pokemon) in
            self.output?.dataFetched(pokemon)
        }
    }
    
    func saveFavorite(pokemon: Pokemon) {
        requestMaker.make(withEndpoint: .pokemon(query: String(pokemon.id)), send: pokemon) {
            (data: Pokemon) in
            self.output?.pokemonSaved(pokemon)
        }
    }
    
}
