//
//  MoveListViewController.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 08/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class MoveListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let requestMaker = RequestMaker()
    
    var moveList = [Move]()
    
    var searchList = [Move]()
    
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

extension MoveListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "move", for: indexPath)
        
        let background = UIView()
        background.backgroundColor = (searchList[indexPath.row].type.color)?.withAlphaComponent(0.1)
        cell.selectedBackgroundView = background
        
        if let moveCell = cell as? MoveTableViewCell {
            moveCell.config(with: searchList[indexPath.row])
        }
        
        return cell
    }
    
}

extension MoveListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "MoveDetailViewController") as? MoveDetailViewController {
            detailViewController.moveName = searchList[indexPath.row].name
            navigationController?.present(detailViewController, animated: true)
        }
    }
    
}

extension MoveListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList = moveList.filter({ $0.name.lowercased().prefix(searchText.count) == searchText.lowercased() })
        tableView.reloadData()
    }
    
}

extension MoveListViewController {
    
    func fetchData() {
        requestMaker.make(withEndpoint: .moves) {
            (moveList: [Move]) in
            self.moveList = moveList
            self.searchList = moveList
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
