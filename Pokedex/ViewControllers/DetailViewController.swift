//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 08/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var superView: GradientView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var pokemonTypeView: PokemonTypeView!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    @IBOutlet weak var imageCenterVertically: NSLayoutConstraint!
    @IBOutlet weak var imageConstraintTop: NSLayoutConstraint!
    @IBOutlet weak var whitePanelTopConstraint: NSLayoutConstraint!
    
    let requestMaker: RequestMaker = RequestMaker()
    
    @IBAction func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        fetchData()
        if let type = pokemon?.types.first {
            pokemonTypeView.config(type: type)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if pokemon?.description == nil { self.loadingAnimation() }
    }
    
    func loadingAnimation() {
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.imageView.alpha = 0.2
        })
    }
    
    func animateImageToTop() {
        self.imageView.layer.removeAllAnimations()
        
        self.imageCenterVertically.priority = UILayoutPriority(rawValue: 949)
        self.imageWidth.priority = UILayoutPriority(rawValue: 949)
        self.imageHeight.priority = UILayoutPriority(rawValue: 949)
        self.whitePanelTopConstraint.priority = UILayoutPriority(rawValue: 949)
        
        UIView.animate(withDuration: 1) {
            self.imageView.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    func config() {
        if let pokemon = self.pokemon {
            superView.setGradientColor(regressing: pokemon.types.first?.color)
            imageView.loadImage(from: pokemon.image)
        }
    }
    
}

extension DetailViewController {
    
    func fetchData() {
        if let pokemon = self.pokemon {
            requestMaker.make(withEndpoint: .details(query: pokemon.id)) {
                (pokemon: Pokemon) in
                
                self.pokemon = pokemon
                DispatchQueue.main.async {
                    self.animateImageToTop()
                }
            }
        }
    }
    
}
