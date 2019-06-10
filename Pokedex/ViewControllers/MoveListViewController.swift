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
    
    let requestMaker = RequestMaker()
    
    var moveList = [Move]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return moveList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "move", for: indexPath)
        
        if let pokemonCell = cell as? MoveTableViewCell {
            pokemonCell.config(with: moveList[indexPath.row])
        }
        
        return cell
    }
    
}

extension MoveListViewController: UITableViewDelegate {
    
}

extension MoveListViewController {
    
    func fetchData() {
        requestMaker.make(withEndpoint: .moves) {
            (moveList: [Move]) in
            self.moveList = moveList
            
            print(moveList)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
