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
    
    private let requestMaker = RequestMaker()
    
    private var pokemonList = [Pokemon]()
    
    private var searchList = [Pokemon]()
    
    func pokemon(at index: Int) -> Pokemon {
        return searchList[index]
    }
    
    func filterPokemons(with text: String) {
        searchList = pokemonList.filter({ $0.name.lowercased().prefix(text.count) == text.lowercased() })
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

extension PokemonListPresenter {
    
    func fetchData() {
        requestMaker.make(withEndpoint: .list) {
            (pokemonList: PokemonList) in
            self.pokemonList = pokemonList.pokemons
            self.searchList = pokemonList.pokemons
            
            DispatchQueue.main.async {
                self.view?.reloadData()
            }
        }
    }
    
}
