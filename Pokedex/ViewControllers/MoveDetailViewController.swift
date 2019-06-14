//
//  MoveDetailViewController.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 10/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class MoveDetailViewController: UIViewController {
    
    var move: Move!
    
    let requestMaker = RequestMaker()
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pokemonType: PokemonTypeView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var powerTitleLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var accuracyTitleLabel: UILabel!
    @IBOutlet weak var ppLabel: UILabel!
    @IBOutlet weak var ppTitleLabel: UILabel!
    
    @IBOutlet weak var imageCenterVertically: NSLayoutConstraint!
    @IBOutlet weak var whitePanelTopConstraint: NSLayoutConstraint!
    
    @IBAction func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        config()
        fetchData()
    }
    
    func animateImageToTop() {
        imageCenterVertically.priority = UILayoutPriority(rawValue: 949)
        whitePanelTopConstraint.priority = UILayoutPriority(rawValue: 949)
        
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func config(move: MoveDetail) {
        
        
        let color = move.type.name.color
        
        titleLabel.text = move.name.capitalized
        
        pokemonType.config(type: move.type.name)
        
        descriptionLabel.text = move.effectEntries.first?.effect
        
        powerTitleLabel.textColor = color
        accuracyTitleLabel.textColor = color
        ppTitleLabel.textColor = color
        
        powerLabel.text = "\(move.power ?? 0)"
        accuracyLabel.text = "\(move.accuracy ?? 0)%"
        ppLabel.text = "\(move.pp ?? 0)"
    }
    
    func config() {
        if let superView = view as? GradientView {
            superView.setGradientColor(regressing: move.type.color)
        }
        
        iconImageView.image = move.type.icon
        
        if let superView = iconImageView.superview as? GradientView {
            superView.setGradientColor(regressing: move.type.color)
            superView.setShadow(color: move.type.color)
        }
        
    }
    
}

extension MoveDetailViewController {
    
    func fetchData() {
        requestMaker.make(withEndpoint: .move(query: move.name)) {
            (move: MoveDetail) in
            
            DispatchQueue.main.async {
                self.config(move: move)
                self.animateImageToTop()
            }
        }
    }
    
}
