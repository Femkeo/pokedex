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
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLvL: String!
    private var _pokemonUrl: String!
    
    var name: String{
        return _name
    }
    
    var pokedexId: Int{
        return _pokedexId
    }
    
    var description: String{
        if _description == nil{
            _description = ""
        }
        return _description!
    }
    
    var type: String{
        if _type == nil{
            _type = ""
        }
        return _type
    }
    
    var defense: String{
        if _defense == nil{
            _defense = ""
        }
        return _defense
    }
    
    var height: String{
        if _height == nil{
            _height = ""
        }
        return _height
    }
    
    var attack: String{
        if _attack == nil{
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionTxt: String{
        if _nextEvolutionTxt == nil{
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var nextEvolutionId: String{
        if _nextEvolutionId == nil{
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLvl: String{
            if _nextEvolutionLvL == nil{
                _nextEvolutionLvL = ""
            }
            return _nextEvolutionLvL
    }
    
    var weight: String{
            if _weight == nil{
                //return an empty string in the return
                _weight = ""
            }
            return _weight
    }
    
    
    
    init (name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId!)/"
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete){

            Alamofire.request(_pokemonUrl).responseJSON { response in
                
                    if let dict = response.result.value as? Dictionary<String, AnyObject>{
                        print(dict["weight"]!)
                        if let weight = dict["weight"] as? String{
                            self._weight = weight
                        }
                        
                        if let height = dict["height"] as? String{
                            self._height = height
                        }
                        
                        if let attack = dict["attack"] as? Int{
                            self._attack = "\(attack)"
                        }
                        
                        if let defense = dict["defense"] as? Int{
                            self._defense = "\(defense)"
                        }
                        
                        print(self._weight)
                        print(self._defense)
                        print(self._attack)
                        print(self._defense)
                        
                        //this means where types.count is bigger than 0. where can be left out
                        if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                            //["name"] directly behind means a new if let name = ["name"]. This is obviously shorter
                            if let name = types[0]["name"]{
                                self._type = name
                            }
                            if types.count > 1 {
                                for x in 1 ..< types.count {
                                    if let name = types[x]["name"]{
                                    self._type! += "/\(name)"
                                    }
                                }
                            }
                        }else{
                            self._type = ""
                        }
                        
                        print(self._type)
                        if let descriptionArray = dict["descriptions"] as? [Dictionary<String, String>], descriptionArray.count > 0 {
                            print("contact1")
                            if let url = descriptionArray[0]["resource_uri"] {
                                let nsurl = "\(URL_BASE)\(url)"
                                Alamofire.request(nsurl).responseJSON { response in
                                    print("contact2")
                                    if let descriptionDictionairy = response.result.value as? Dictionary<String, AnyObject>{
                                        if let description = descriptionDictionairy["description"] as? String{
                                            self._description = description
                                            print(self._description)
                                        }
                                    }
                                }
                            }
                        }else{
                            self._description = ""
                        }
                        
                        if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0{
                            if let evolveTo = evolutions[0]["to"] as? String{
                                //this means mega is nog found to exclude mega evolutions
                                if evolveTo.range(of: "mega") == nil {
                                    let uri = evolutions[0]["resource_uri"] as? String
                                    let newStr = uri?.replacingOccurrences(of: "api/v1/pokemon/", with: "")
                                    let onlyNumber = newStr?.replacingOccurrences(of: "/", with: "")
                                    self._nextEvolutionId = onlyNumber
                                    self._nextEvolutionTxt = evolveTo
                                    
                                    if let lvl = evolutions[0]["level"] as? Int{
                                        self._nextEvolutionLvL = "\(lvl)"
                                    }
                                    print(self._nextEvolutionId)
                                    print(self._nextEvolutionTxt)
                                    print(self._nextEvolutionLvL)
                                }
                            }
                        }
                                
                            
                        completed()
  
                        

                    }

            }

        
    }
    
}
