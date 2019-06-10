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
    
}

extension MoveListViewController {
    
    func fetchData() {
        //        requestMaker.make(withEndpoint: .details(query: "1")) {
        //            (pokemon: Pokemon) in
        //            print(pokemon)
        //        }
        requestMaker.make(withEndpoint: .moves) {
            (moveList: [Move]) in
            self.moveList = moveList
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
