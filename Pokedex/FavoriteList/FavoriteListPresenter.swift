//
//  FavoriteListPresenter.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 19/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class FavoriteListPresenter: NSObject {
    
    weak var view: FavoriteListViewType!
    
    private lazy var interactor: FavoriteListInteractorInput = FavoriteListInteractor(output: self)
    
    private var pokemonList = [Pokemon]()
    private var searchList = [Pokemon]()
    
    func filterPokemons(with text: String) {
        searchList = pokemonList.filter({ $0.name.lowercased().prefix(text.count) == text.lowercased() })
    }
    
}

extension FavoriteListPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favorite", for: indexPath)
        
        if let pokemonCell = cell as? FavoriteCollectionViewCell {
            pokemonCell.config(with: pokemon(at: indexPath.item))
        }
        
        return cell
    }
    
}

extension FavoriteListPresenter: FavoriteListPresenterType {
    
    func fetchData() {
        interactor.fetchData()
    }
    
    func pokemon(at index: Int) -> Pokemon {
        return searchList[index]
    }
    
    
}

extension FavoriteListPresenter: FavoriteListInteractorOutput {
    
    func dataFetched(_ data: [Pokemon]) {
        pokemonList = data
        searchList = data
        
        DispatchQueue.main.async {
            self.view.reloadData()
        }
        print(pokemonList)
    }
    
}
