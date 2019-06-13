//
//  StatBarView.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 12/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class StatBarView: UIView {
    
    let nibName = "StatBarView"
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var value: UILabel!
    
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
    
    func config(stat: Stat) {
        name.text = stat.name.uppercased()
        value.text = String(format: "%03d", stat.value)
    }
    
}
