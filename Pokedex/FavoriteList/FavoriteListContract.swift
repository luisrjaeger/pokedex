//
//  FavoriteListContract.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 19/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

protocol FavoriteListViewType: AnyObject {
    //func reloadSingleItem(at index: Int)
    func reloadData()
}

protocol FavoriteListPresenterType {
    var view: FavoriteListViewType! { get set }
    func fetchData()
    func pokemon(at index: Int) -> Pokemon
    func toggleRemoveEnabled()
    func remove(at index: Int)
}

protocol FavoriteListInteractorInput: AnyObject {
    var output: FavoriteListInteractorOutput! { get set }
    func fetchData()
    func removeFavorite(pokemon: Pokemon)
}

protocol FavoriteListInteractorOutput: AnyObject {
    func dataFetched(_ data: [Pokemon])
    func pokemonSaved(_ data: Pokemon)
}
