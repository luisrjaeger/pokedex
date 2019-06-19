//
//  FavoriteListViewController.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 19/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class FavoriteListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var activityView: UIView!
    
    private var presenter = FavoriteListPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.view = self
        collectionView.dataSource = presenter
        
        searchBar.delegate = self
        collectionView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.fetchData()
    }
    
}

extension FavoriteListViewController: FavoriteListViewType {
    
    func reloadData() {
        collectionView.reloadData()
        self.activityView.isHidden = true
    }
    
}

extension FavoriteListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.filterPokemons(with: searchText)
        collectionView.reloadData()
    }
    
}

extension FavoriteListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.toggleRemoveEnabled()
    }
    
}
