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
        idLabel.text = " #\(model.id.leftPadding(toLength: 3, withPad: "0"))"
        primaryType.image = model.types.first?.icon
        (primaryType.superview as? GradientView)?.startColor = model.types.first?.color ?? .white
        (primaryType.superview as? GradientView)?.endColor = (model.types.first?.color ?? .white).withAlphaComponent(0.5)
        
        if model.types.count > 1 {
            let type = model.types[1]
            
            secondaryType.superview?.isHidden = false
            secondaryType.image = type.icon
            (secondaryType.superview as? GradientView)?.startColor = type.color ?? .white
            (secondaryType.superview as? GradientView)?.endColor = (type.color ?? .white).withAlphaComponent(0.5)
        } else {
            secondaryType.superview?.isHidden = true
        }
        
    }
    
}
