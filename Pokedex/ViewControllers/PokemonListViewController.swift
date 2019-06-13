//
//  ViewController.swift
//  Pokedex
//
//  Created by Juliano Nardon on 07/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class PokemonListViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityView: UIView!
    
    let requestMaker = RequestMaker()
    
    var pokemonList = [Pokemon]()
    
    var searchList = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        configTable()
        fetchData()
    }

    private func configTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension PokemonListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemon", for: indexPath)
        
        let background = UIView()
        background.backgroundColor = searchList[indexPath.row].types.first?.color?.lighter() ?? .gray
        cell.selectedBackgroundView = background
        
        if let pokemonCell = cell as? PokemonTableViewCell {
            pokemonCell.config(with: searchList[indexPath.row])
        }
        
        return cell
    }
    
}

extension PokemonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") {
            (detailViewController as? DetailViewController)?.pokemon = searchList[indexPath.row]
            
            navigationController?.present(detailViewController, animated: true)
        }
    }
    
}

extension PokemonListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList = pokemonList.filter({ $0.name.lowercased().prefix(searchText.count) == searchText.lowercased() })
        tableView.reloadData()
    }
    
}

extension PokemonListViewController {
    
    func fetchData() {
        requestMaker.make(withEndpoint: .list) {
            (pokemonList: PokemonList) in
            self.pokemonList = pokemonList.pokemons
            self.searchList = pokemonList.pokemons
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityView.isHidden = true
            }
        }
    }
    
}
