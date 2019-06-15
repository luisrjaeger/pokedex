//
//  ViewController.swift
//  Pokedex
//
//  Created by Juliano Nardon on 07/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

protocol PokemonListViewType: AnyObject {
    func reloadData()
}

class PokemonListViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityView: UIView!
    
    private let presenter = PokemonListPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.view = self
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        configTable()
        presenter.fetchData()
    }

    private func configTable() {
        tableView.dataSource = presenter
        tableView.delegate = self
    }
    
}

extension PokemonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") {
            (detailViewController as? DetailViewController)?.pokemon = presenter.pokemon(at: indexPath.row)
            
            navigationController?.present(detailViewController, animated: true)
        }
    }
    
}

extension PokemonListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.filterPokemons(with: searchText)
        tableView.reloadData()
    }
    
}

extension PokemonListViewController: PokemonListViewType {
    
    func reloadData() {
        self.tableView.reloadData()
        self.activityView.isHidden = true
    }
    
}
