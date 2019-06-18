//
//  PokemonListPresenter.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 15/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class PokemonListPresenter: NSObject {
    
    weak var view: PokemonListViewType?
    
    private lazy var interactor: PokemonListInteractorInput = PokemonListInteractor(output: self)
    
    private var pokemonList = [Pokemon]()
    
    private var searchList = [Pokemon]()
    
    private let idKey = "favorite.ids"
    
//    override init() {
//        super.init()
//
//        if let data = UserDefaults.standard.array(forKey: idKey) as? [Int] {
//            favoriteIds = Set(data)
//        }
//    }
//
//    private var favoriteIds = Set<Int>() {
//        didSet {
//            print(favoriteIds)
//            UserDefaults.standard.set(Array(favoriteIds), forKey: idKey)
//        }
//    }
    
    func fetchData() {
        interactor.fetchData()
    }
    
    func pokemon(at index: Int) -> Pokemon {
        return searchList[index]
    }
    
    func filterPokemons(with text: String) {
        searchList = pokemonList.filter({ $0.name.lowercased().prefix(text.count) == text.lowercased() })
    }
    
    func swipe(at index: Int) {
        //let pokemonId = pokemon(at: index).id
        var poke = pokemon(at: index)
        poke.favorite = !poke.favorite
        interactor.saveFavorite(pokemon: poke)
        
//        guard favoriteIds.contains(pokemonId) else {
//            favoriteIds.insert(pokemonId)
//            return
//        }
//
//        favoriteIds.remove(pokemonId)
    }
    
    func swipeAction(for index: Int) -> PokemonSwipeAction {
        return pokemon(at: index).favorite ? .removeFavorite : .addFavorite
//        return favoriteIds.contains(pokemon(at: index).id) ? .removeFavorite : .addFavorite
    }
    
}

extension PokemonListPresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemon", for: indexPath)
        
        let background = UIView()
        background.backgroundColor = (searchList[indexPath.row].types.first?.color ?? .gray).withAlphaComponent(0.1)
        cell.selectedBackgroundView = background
        
        if let pokemonCell = cell as? PokemonTableViewCell {
            pokemonCell.config(with: searchList[indexPath.row])
        }
        
        return cell
    }
    
}

extension PokemonListPresenter: PokemonListInteractorOutput {
    
    func dataFetched(_ data: [Pokemon]) {
        pokemonList = data
        searchList = data

        DispatchQueue.main.async {
            self.view?.reloadData()
        }
    }
    
    func pokemonSaved(_ data: Pokemon) {
        if let index = pokemonList.firstIndex(where: { $0.id == data.id }) {
            pokemonList[index] = data
        }
        
        if let index = searchList.firstIndex(where: { $0.id == data.id }) {
            searchList[index] = data
            DispatchQueue.main.async {
                self.view?.reloadSingleItem(at: index)
            }
        }
    }
    
}
