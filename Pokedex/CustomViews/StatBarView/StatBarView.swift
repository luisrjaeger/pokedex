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
    
    @IBOutlet weak var bar: GradientView!
    
    @IBOutlet weak var barContent: GradientView!
    @IBOutlet weak var barContentConstraint: NSLayoutConstraint!
    
    @IBInspectable var statLabel: String = ""
    
    var baseValue: Float!
    
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
    
    func config(stat: Stat?, color: UIColor?) {
        if let stat = stat {
            name.text = statLabel
            value.text = String(format: "%03d", stat.value)            
        }
        
        name.textColor = color
        barContent.setGradientColor(progressing: color)
        
        baseValue = Float(bar.frame.width) / 150
        
        UIView.animate(withDuration: 1, delay: 1, animations: {
            self.barContentConstraint.constant = CGFloat(self.baseValue * Float(stat?.value ?? 0) - Float(self.bar.frame.width))
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
}
