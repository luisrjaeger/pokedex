//
//  FavoriteCollectionViewCell.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 19/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: GradientView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var primaryTypeView: TypeView!
    @IBOutlet weak var secondaryTypeView: TypeView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func config(with model: Pokemon, isRemoveEnabled removeEnabled: Bool) {
        backView.setGradientColor(regressing: model.mainType?.color)
        imageView.loadImage(from: model.image)
        
        nameLabel.text = model.name
        
        if removeEnabled {
            backView.shake()
        }
        
        statLabel.textColor = model.mainType?.color
        if let stat = model.strongestStat {
            statLabel.text = stat.name.shortName.uppercased()
            valueLabel.text = String(stat.value)
        }
        
        primaryTypeView.config(type: model.mainType!)
        
        if model.types.count > 1 {
            let type = model.types[1]
            secondaryTypeView.isHidden = false
            secondaryTypeView.config(type: type)
        } else {
            secondaryTypeView.isHidden = true
        }
    }
    
}
