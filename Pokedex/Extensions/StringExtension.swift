//
//  StringExtension.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 08/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

extension String {
    
    func leftPadding(toLength: Int, withPad character: Character) -> String {
        
        let newLength = self.count
        
        if newLength < toLength {
            
            return String(repeatElement(character, count: toLength - newLength)) + self
            
        } else {
            
            return String(self[(index(startIndex, offsetBy: newLength - toLength))...])
            //self.substring(from: index(self.startIndex, offsetBy: newLength - toLength))
            
        }
    }
    
}
