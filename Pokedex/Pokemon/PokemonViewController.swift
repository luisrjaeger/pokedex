//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 08/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var superView: GradientView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var pokemonTypeView: PokemonTypeView!
    @IBOutlet weak var pokemonTypeView2: PokemonTypeView!
    @IBOutlet weak var descriptionView: UILabel!
    @IBOutlet weak var statLabel: UILabel!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    @IBOutlet weak var imageCenterVertically: NSLayoutConstraint!
    @IBOutlet weak var whitePanelTopConstraint: NSLayoutConstraint!
    
    @IBOutlet var statsView: [StatBarView]!
    
    var presenter: PokemonPresenterType!
    
    @IBAction func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func favoriteAction() {
        presenter.onFavoriteClicked()
    }
    
    var color: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "detailView"
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter.viewDidAppear()
    }
    
}

extension PokemonViewController: PokemonViewType {
    
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
    
    func configFirstInformation(for pokemon: Pokemon) {
        color = pokemon.types.first?.color
        
        superView.setGradientColor(regressing: color)
        imageView.loadImage(from: pokemon.image)
        statLabel.textColor = color
        
        name.text = pokemon.name.capitalized
    }
    
    func configTypes(_ types: [PokemonType]) {
        if let type = types.first {
            pokemonTypeView.config(type: type)
        }
        
        guard types.count > 1 else {
            return
        }
        
        pokemonTypeView2.isHidden = false
        pokemonTypeView2.config(type: types[1])
    }
    
    func configStats(for pokemon: Pokemon) {
        descriptionView.text = pokemon.description
        
        if let stats = pokemon.stats {
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
    
    func loadingAnimation() {
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.imageView.alpha = 0.2
        })
    }
    
    func configFavorite(checked favorite: Bool) {
        let tintableImg = UIImage.star.withRenderingMode(.alwaysTemplate)
        favoriteButton.setImage(tintableImg, for: .normal)
        favoriteButton.tintColor = favorite ? .orange : .gray
    }
    
}
