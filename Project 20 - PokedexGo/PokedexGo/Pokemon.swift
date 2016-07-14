//
//  Pokemon.swift
//  PokedexGo
//
//  Created by Yi Gu on 7/10/16.
//  Copyright © 2016 yigu. All rights reserved.
//

import UIKit

enum PokeType {
  case Normal
  case Fire
  case Water
  case Electric
  case Grass
  case Ice
  case Fighting
  case Poison
  case Ground
  case Flying
  case Psychic
  case Bug
  case Rock
  case Ghost
  case Dragon
  case Dark
  case Steel
  case Fairy
}

class Pokemon: NSObject {
  let name: String
  let id: Int
  let detailInfo: String
  let type: [PokeType]
  let weak: [PokeType]
  let pokeImgUrl: String
  
  init(name: String, id: Int, detailInfo: String, type: [PokeType], weak: [PokeType], pokeImgUrl: String) {
    self.name = name
    self.id = id
    self.detailInfo = detailInfo
    self.type = type
    self.weak = weak
    self.pokeImgUrl = pokeImgUrl
  }
}
