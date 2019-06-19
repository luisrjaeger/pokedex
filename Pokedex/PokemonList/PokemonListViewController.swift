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
    
    private let presenter = PokemonListPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.view = self
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        configTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
            let pokemon = presenter.pokemon(at: indexPath.row)
            (detailViewController as? PokemonViewController)?.presenter =
                PokemonPresenter(pokemon: pokemon, view: detailViewController as! PokemonViewType)
            
            navigationController?.present(detailViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let actionType = presenter.swipeAction(for: indexPath.row)
        
        let contextualAction = UIContextualAction(style: .normal, title: actionType.text) { (action, view, handler) in
            
            self.presenter.swipe(at: indexPath.row)
            
            handler(true)
        }
        
        contextualAction.backgroundColor = actionType.color
        contextualAction.image = .pikachu
        
        let configuration = UISwipeActionsConfiguration(actions: [contextualAction])
        
        return configuration
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return .init()
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
    
    func reloadSingleItem(at index: Int) {
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: UITableView.RowAnimation.none)
    }
    
}

enum PokemonSwipeAction {
    
    case addFavorite, removeFavorite
    
    var text: String {
        switch self {
        case .addFavorite:
            return "Favorite"
        case .removeFavorite:
            return "Remove"
        }
    }
    
    var color: UIColor {
        switch self {
        case .addFavorite:
            return .orange
        case .removeFavorite:
            return .gray
        }
    }
    
}
