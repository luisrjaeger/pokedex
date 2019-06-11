//
//  MoveDetailViewController.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 10/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class MoveDetailViewController: UIViewController {
    
    var moveName: String = ""
    
    let requestMaker = RequestMaker()
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconTypeLabelImageView: UIImageView!
    @IBOutlet weak var nameTypeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var ppLabel: UILabel!
    
    @IBAction func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        fetchData()
    }
    
    private func config(move: MoveDetail) {
        if let superView = view as? GradientView { superView.setGradientColor(to: move.type.name.color) }
        
        let icon = move.type.name.icon
        let color = move.type.name.color
        
        titleLabel.text = move.name.capitalized
        
        iconImageView.image = icon
        (iconImageView.superview as? GradientView)?.setGradientColor(to: color)
        
        nameTypeLabel.text = move.type.name.rawValue.uppercased()
        
        iconTypeLabelImageView.image = icon
        (iconTypeLabelImageView.superview as? GradientView)?.setGradientColor(to: color)
        
    }
    
}

extension MoveDetailViewController {
    
    func fetchData() {
        requestMaker.make(withEndpoint: .move(query: moveName)) {
            (move: MoveDetail) in
            
            DispatchQueue.main.async {
                self.config(move: move)
            }
        }
    }
    
}
