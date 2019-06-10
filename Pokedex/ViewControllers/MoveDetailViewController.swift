//
//  MoveDetailViewController.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 10/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class MoveDetailViewController: UIViewController {
    
    var moveName: String = ""
    
    let requestMaker = RequestMaker()
    
    @IBAction func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        fetchData()
    }
    
    private func config(move: MoveDetail) {
        if let superView = view as? GradientView {
            superView.startColor = move.type.name.color ?? .white
            superView.endColor = (move.type.name.color ?? .white).withAlphaComponent(0.5)
        }
    }
    
}

extension MoveDetailViewController {
    
    func fetchData() {
        requestMaker.make(withEndpoint: .move(query: moveName)) {
            (move: MoveDetail) in
            
            DispatchQueue.main.async {
                self.config(move: move)
            }
        }
    }
    
}
