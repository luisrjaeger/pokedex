//
//  PokemonContract.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 17/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

protocol PokemonViewType: AnyObject {
    func animateImageToTop()
    func configFirstInformation(for pokemon: Pokemon)
    func configTypes(_ types: [PokemonType])
    func configStats(for pokemon: Pokemon)
    func configFavorite(checked favorite: Bool)
    func loadingAnimation()
}

protocol PokemonPresenterType {
    var view: PokemonViewType! { get set }
    func onFavoriteClicked()
    func viewDidLoad()
    func viewDidAppear()
}

protocol PokemonInteractorInput: AnyObject {
    var output: PokemonInteractorOutput! { get set }
    func fetchData(pokemonId: Int)
    func saveFavorite(pokemon: Pokemon)
}

protocol PokemonInteractorOutput: AnyObject {
    func dataFetched(_ data: Pokemon)
    func pokemonSaved(_ data: Pokemon)
}
