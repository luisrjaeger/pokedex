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
    @IBOutlet weak var type: UIImageView!

    func config(with model: Move) {
        nameLabel.text = model.name.capitalized
        
        type.image = model.type.icon
        (type.superview as? GradientView)?.startColor = model.type.color ?? .white
        (type.superview as? GradientView)?.endColor = (model.type.color ?? .white).withAlphaComponent(0.5)
    }
    
}