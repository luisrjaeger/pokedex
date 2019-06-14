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
    @IBOutlet weak var primaryTypeView: TypeView!
    @IBOutlet weak var secondaryTypeView: TypeView!

    func config(with model: Pokemon) {
        pictureImageView.loadImage(from: model.image)
        
        nameLabel.text = model.name.capitalized
        idLabel.text = String(format: "#%03d", model.id)
//        primaryType.image = model.types.first?.icon
        
//        if let superView = primaryType.superview as? GradientView {
//            superView.setGradientColor(regressing: model.types.first?.color)
//            superView.setShadow(color: model.types.first?.color)
//
//        }
        primaryTypeView.config(type: model.types.first)

        
        if model.types.count > 1 {
            let type = model.types[1]
            
            secondaryType.superview?.isHidden = false
            secondaryType.image = type.icon
//            if let superView = secondaryType.superview as? GradientView {
//                superView.setGradientColor(regressing: type.color)
//                superView.setShadow(color: type.color)
//
//            }
            secondaryTypeView.config(type: type)
        } else {
            secondaryTypeView.isHidden = true
//            secondaryType.superview?.isHidden = true
        }
        
    }
    
}
