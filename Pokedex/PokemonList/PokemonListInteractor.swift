//
//  PokemonListInteractor.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 15/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

class PokemonListInteractor: PokemonListInteractorInput {
    
    private let requestMaker = RequestMaker()
    
    weak var output: PokemonListInteractorOutput!
    
    init(output: PokemonListInteractorOutput) {
        self.output = output
    }
    
    func fetchData() {
        requestMaker.make(withEndpoint: .pokemons) {
            (pokemonList: [Pokemon]) in
            self.output?.dataFetched(pokemonList)
        }
    }
    
    func saveFavorite(pokemon: Pokemon) {
        requestMaker.make(withEndpoint: .pokemon(query: String(pokemon.id)), sending: pokemon) {
            (data: Pokemon) in
            self.output?.pokemonSaved(pokemon)
        }
    }
    
}
