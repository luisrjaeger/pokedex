//
//  PokemonPresenter.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 17/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

class PokemonPresenter: NSObject {
    
    private var pokemon: Pokemon!
    weak var view: PokemonViewType!
    
    private lazy var interactor: PokemonInteractorInput = PokemonInteractor(output: self)
    
    init(pokemon: Pokemon, view: PokemonViewType) {
        self.pokemon = pokemon
        self.view = view
    }
    
}

extension PokemonPresenter: PokemonPresenterType {
    
    func viewDidLoad() {
        view?.configFirstInformation(for: pokemon)
        view?.configTypes(pokemon.types)
        interactor.fetchData(pokemonId: pokemon.id)
    }
    
    func viewDidAppear() {
        if pokemon?.description == nil {
            view.loadingAnimation()
        }
    }
    
    func onFavoriteClicked() {
        pokemon.favorite = !pokemon.favorite
        interactor.saveFavorite(pokemon: pokemon)
    }
    
}

extension PokemonPresenter: PokemonInteractorOutput {
    
    func dataFetched(_ data: Pokemon) {
        pokemon = data
        
        DispatchQueue.main.async {
            self.view?.animateImageToTop()
            self.view?.configStats(for: self.pokemon)
            self.view?.configFavorite(checked: self.pokemon.favorite)
        }
    }
    
    func pokemonSaved(_ data: Pokemon) {
        pokemon = data
        
        DispatchQueue.main.async {
            self.view.configFavorite(checked: self.pokemon.favorite)
        }
    }
    
}
