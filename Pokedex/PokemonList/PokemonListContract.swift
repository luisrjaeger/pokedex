//
//  PokemonListContract.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 15/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

protocol PokemonListViewType: AnyObject {
    func reloadData()
    func reloadSingleItem(at index: Int)
}

protocol PokemonListPresenterType {
    var view: PokemonListViewType? { get set }
    func fetchData()
    func pokemon(at index: Int) -> Pokemon
}

protocol PokemonListInteractorInput: AnyObject {
    var output: PokemonListInteractorOutput! { get set }
    func fetchData()
    func saveFavorite(pokemon: Pokemon)
}

protocol PokemonListInteractorOutput: AnyObject {
    func dataFetched(_ data: [Pokemon])
    func pokemonSaved(_ data: Pokemon)
}
