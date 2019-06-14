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
    }
    
    func config(type: PokemonType?) {
        if let type = type {
            
        }
    }
    
}
