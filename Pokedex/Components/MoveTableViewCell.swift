//
//  MoveTableViewCell.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 10/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class MoveTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeView: TypeView!

    func config(with move: Move) {
        nameLabel.text = move.name.capitalized
        typeView.config(type: move.type)
    }
    
}
