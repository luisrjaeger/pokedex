//
//  CustomSearchBar.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 10/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

@IBDesignable
class CustomSearchBar: UISearchBar {

    var textField: UITextField? {
        get { return value(forKey: "searchField") as? UITextField }
    }
    
    @IBInspectable var textBorderColor: UIColor? {
        get { return textField?.layer.borderColor.map(UIColor.init) }
        set { textField?.layer.borderColor = newValue?.cgColor }
    }
    
    @IBInspectable var textBorderWidth: CGFloat {
        get { return textField?.layer.borderWidth ?? 0 }
        set { textField?.layer.borderWidth = newValue }
    }
    
    @IBInspectable var textCornerRadius: CGFloat {
        get { return textField?.layer.cornerRadius ?? 0 }
        set {
            textField?.layer.cornerRadius = newValue
            textField?.clipsToBounds = newValue > 0
        }
    }

}
