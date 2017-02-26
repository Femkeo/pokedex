//
//  Pokemon.swift
//  pokedex
//
//  Created by G.F Offringa on 16-01-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import Foundation
import Alamofire


class Pokemon{
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defence: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _pokemonUrl: String!
    
    var name: String{
        return _name
    }
    
    var pokedexId: Int{
        return _pokedexId
    }
    
    
    
    init (name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete){
        let url = NSURL(string: _pokemonUrl)
        print("HERE IS THE URL \(url!)")
//        Alamofire.request(url as! URLRequestConvertible).responseJSON { response in
//            print(response.request!)  // original URL request
//            print(response.response!) // HTTP URL response
//            print(response.data!)     // server data
//            print(response.result)   // result of response serialization
//            
//            if let JSON = response.result.value {
//                print("JSON: \(JSON)")
//            }
//        }
    }
    
}
