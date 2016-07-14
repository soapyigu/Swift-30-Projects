//
//  PokemonConstants.swift
//  PokedexGo
//
//  Created by Yi Gu on 7/10/16.
//  Copyright © 2016 yigu. All rights reserved.
//

import Foundation

let pokemons = [
  Pokemon(name: "妙蛙种子", id: 1,
  detailInfo: "妙蛙种子经常在阳光下酣睡。它背上有个种子，通过吸收阳光渐渐长大。",
  type: [PokeType.Grass, PokeType.Poison],
  weak: [PokeType.Fire, PokeType.Flying, PokeType.Ice, PokeType.Psychic],
  pokeImgUrl: "http://assets.pokemon.com/assets/cms2/img/pokedex/full/001.png"),
  Pokemon(name: "妙蛙草", id: 2,
    detailInfo: "在它的背上有一个花苞。妙蛙草的四肢非常粗壮，这样才能支撑它的体重。如果它开始经常晒太阳，表明它将要开花了。",
    type: [PokeType.Grass, PokeType.Poison],
    weak: [PokeType.Fire, PokeType.Flying, PokeType.Ice, PokeType.Psychic],
    pokeImgUrl: "http://assets.pokemon.com/assets/cms2/img/pokedex/full/002.png")
]