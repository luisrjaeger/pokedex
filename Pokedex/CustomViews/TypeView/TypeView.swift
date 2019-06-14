//
//  TypeView.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 14/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class TypeView: UIView {
    
    let nibName = "TypeView"
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var circleView: GradientView!
    @IBOutlet weak var iconView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        contentView.fixInView(self)
        circleView.fixInView(contentView)
        circleView.cornerRadius = contentView.frame.width / 2
    }
    
    func config(type: PokemonType?) {
        if let type = type {
            circleView.setGradientColor(regressing: type.color)
            circleView.setShadow(color: type.color)
            
            iconView.image = type.icon
        }
        //layoutIfNeeded()
    }
    
}
