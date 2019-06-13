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
    @IBOutlet weak var primaryType: UIImageView!
    @IBOutlet weak var secondaryType: UIImageView!

    func config(with model: Pokemon) {
        pictureImageView.loadImage(from: model.image)
        
        nameLabel.text = model.name.capitalized
        idLabel.text = String(format: "#%03d", Int(model.id) ?? 0)
        primaryType.image = model.types.first?.icon
        (primaryType.superview as? GradientView)?.setGradientColor(regressing: model.types.first?.color)
        
        if model.types.count > 1 {
            let type = model.types[1]
            
            secondaryType.superview?.isHidden = false
            secondaryType.image = type.icon
            (secondaryType.superview as? GradientView)?.setGradientColor(regressing: type.color)
        } else {
            secondaryType.superview?.isHidden = true
        }
        
    }
    
}
