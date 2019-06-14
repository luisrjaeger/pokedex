//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 08/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var primaryTypeView: TypeView!
    @IBOutlet weak var secondaryTypeView: TypeView!

    func config(with model: Pokemon) {
        pictureImageView.loadImage(from: model.image)
        
        nameLabel.text = model.name.capitalized
        idLabel.text = String(format: "#%03d", model.id)
        primaryTypeView.config(type: model.types.first)

        
        if model.types.count > 1 {
            let type = model.types[1]
            secondaryTypeView.isHidden = false
            secondaryTypeView.config(type: type)
        } else {
            secondaryTypeView.isHidden = true
        }
        
    }
    
}
