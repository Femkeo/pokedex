//
//  PokeCell.swift
//  pokedex
//
//  Created by G.F Offringa on 19-01-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!

    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    
    func configureCell(pokemon: Pokemon){
        //self is used, because it's the same as the aquired name)
        self.pokemon = pokemon
        nameLbl.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
        
    }
}
