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
    @IBOutlet weak var descriptionView: UILabel!
    @IBOutlet weak var statLabel: UILabel!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    @IBOutlet weak var imageCenterVertically: NSLayoutConstraint!
    @IBOutlet weak var imageConstraintTop: NSLayoutConstraint!
    @IBOutlet weak var whitePanelTopConstraint: NSLayoutConstraint!
    
//    @IBOutlet weak var hp: StatBarView!
//    @IBOutlet weak var atk: StatBarView!
//    @IBOutlet weak var def: StatBarView!
//    @IBOutlet weak var satk: StatBarView!
//    @IBOutlet weak var sdef: StatBarView!
//    @IBOutlet weak var spd: StatBarView!
    
    @IBOutlet var statsView: [StatBarView]!
    
    let requestMaker: RequestMaker = RequestMaker()
    
    @IBAction func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    var pokemon: Pokemon?
    var color: UIColor?
    
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
        imageView.layer.removeAllAnimations()
        
        imageCenterVertically.priority = UILayoutPriority(rawValue: 949)
        imageWidth.priority = UILayoutPriority(rawValue: 949)
        imageHeight.priority = UILayoutPriority(rawValue: 949)
        whitePanelTopConstraint.priority = UILayoutPriority(rawValue: 949)
        
        UIView.animate(withDuration: 1) {
            self.imageView.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    func config() {
        if let pokemon = self.pokemon {
            color = pokemon.types.first?.color
            
            superView.setGradientColor(regressing: color)
            imageView.loadImage(from: pokemon.image)
            statLabel.textColor = color
            
            name.text = pokemon.name.capitalized
        }
    }
    
    func configStats() {
        descriptionView.text = pokemon?.description//?.removingAllNewlines
        
        if let stats = pokemon?.stats {
            for stat in stats {
                switch stat.name {
                case .hp:
                    statsView[0].config(stat: stat, color: color)
                case .atk:
                    statsView[1].config(stat: stat, color: color)
                case .def:
                    statsView[2].config(stat: stat, color: color)
                case .satk:
                    statsView[3].config(stat: stat, color: color)
                case .sdef:
                    statsView[4].config(stat: stat, color: color)
                case .spd:
                    statsView[5].config(stat: stat, color: color)
                }
            }
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
                    self.configStats()
                }
            }
        }
    }
    
}
