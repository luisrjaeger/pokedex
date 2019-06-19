//
//  FavoriteListInteractor.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 19/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

class FavoriteListInteractor {
    
    private let requestMaker = RequestMaker()
    
    weak var output: FavoriteListInteractorOutput!
    
    init(output: FavoriteListInteractorOutput) {
        self.output = output
    }
    
}

extension FavoriteListInteractor: FavoriteListInteractorInput {
    
    func fetchData() {
        requestMaker.make(withEndpoint: .favorites) {
            (pokemonList: [Pokemon]) in
            self.output.dataFetched(pokemonList)
        }
    }
    
}
