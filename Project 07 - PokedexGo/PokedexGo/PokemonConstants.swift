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
    type: [PokeType.grass, PokeType.poison],
    weak: [PokeType.fire, PokeType.flying, PokeType.ice, PokeType.psychic],
    pokeImgUrl: "http://assets.pokemon.com/assets/cms2/img/pokedex/full/001.png"),
  
  Pokemon(name: "妙蛙草", id: 2,
    detailInfo: "在它的背上有一个花苞。妙蛙草的四肢非常粗壮，这样才能支撑它的体重。如果它开始经常晒太阳，表明它将要开花了。",
    type: [PokeType.grass, PokeType.poison],
    weak: [PokeType.fire, PokeType.flying, PokeType.ice, PokeType.psychic],
    pokeImgUrl: "http://assets.pokemon.com/assets/cms2/img/pokedex/full/002.png"),
  
  Pokemon(name: "妙蛙花", id: 3,
    detailInfo: "妙蛙花的背上有一朵巨大的鲜花。如果它吸收养分、晒太阳，花的颜色就会变得非常鲜艳。花的香气还可以抚慰伤感的人。",
    type: [PokeType.grass, PokeType.poison],
    weak: [PokeType.fire, PokeType.flying, PokeType.ice, PokeType.psychic],
    pokeImgUrl: "http://assets.pokemon.com/assets/cms2/img/pokedex/full/003.png"),
  
  Pokemon(name: "小火龙", id: 4,
    detailInfo: "它尾巴上的火焰能够表现出它的情绪。当它开心时，火焰会摇曳。如果它被激怒，火焰就会猛烈地燃烧。",
    type: [PokeType.fire],
    weak: [PokeType.ground, PokeType.rock, PokeType.water],
    pokeImgUrl: "http://assets.pokemon.com/assets/cms2/img/pokedex/full/004.png"),
  
  Pokemon(name: "火恐龙", id: 5,
    detailInfo: "火恐龙会用它锋利的爪子残忍地撕裂敌人。如果它的敌人十分强壮，它就会变得好斗。在这种情况下，它尾巴上的火焰会变成带点蓝色的亮白。",
    type: [PokeType.fire],
    weak: [PokeType.ground, PokeType.rock, PokeType.water],
    pokeImgUrl: "http://assets.pokemon.com/assets/cms2/img/pokedex/full/005.png"),
  
  Pokemon(name: "喷火龙", id: 6,
    detailInfo: "喷火龙在空中飞行，寻找强大的对手。它吐出的火焰温度极高，可以融化一切物体。然而，它从来不攻击任何比它弱小的对手。",
    type: [PokeType.fire, PokeType.flying],
    weak: [PokeType.ground, PokeType.electric, PokeType.water],
    pokeImgUrl: "http://assets.pokemon.com/assets/cms2/img/pokedex/full/006.png"),
  
  Pokemon(name: "杰尼龟", id: 7,
    detailInfo: "杰尼龟的壳不仅仅用来保护自己。它圆形的壳和表明的沟壑减小了它在水中的阻力，让这只神奇宝贝能高速游泳。",
    type: [PokeType.water],
    weak: [PokeType.electric, PokeType.grass],
    pokeImgUrl: "http://assets.pokemon.com/assets/cms2/img/pokedex/full/007.png"),

  Pokemon(name: "卡咪龟", id: 8,
    detailInfo: "蓬松的毛覆盖的大大的尾巴的颜色会随着年龄的增长而变深。背甲上的伤痕是强者的证明。",
    type: [PokeType.water],
    weak: [PokeType.electric, PokeType.grass],
    pokeImgUrl: "http://assets.pokemon.com/assets/cms2/img/pokedex/full/008.png"),
  
  Pokemon(name: "水箭龟", id: 9,
    detailInfo: "水箭龟背甲上伸出喷射口，可以精确瞄准，水弹可以击中50米外的空罐子。",
    type: [PokeType.water],
    weak: [PokeType.electric, PokeType.grass],
    pokeImgUrl: "http://assets.pokemon.com/assets/cms2/img/pokedex/full/009.png"),
  
  Pokemon(name: "绿毛虫", id: 10,
    detailInfo: "有着很好的食欲，可以瞬间吃掉比身体还大的叶子。触角会释放出强烈的臭味。",
    type: [PokeType.bug],
    weak: [PokeType.fire, PokeType.flying, PokeType.rock],
    pokeImgUrl: "http://assets.pokemon.com/assets/cms2/img/pokedex/full/010.png"),
  
  Pokemon(name: "铁甲蛹", id: 11,
    detailInfo: "身体外面的壳有铁板那么硬。不怎么移动是因为里面柔软的身体正在准备进化。",
    type: [PokeType.bug],
    weak: [PokeType.fire, PokeType.flying, PokeType.rock],
    pokeImgUrl: "http://assets.pokemon.com/assets/cms2/img/pokedex/full/011.png"),
  
  Pokemon(name: "巴大蝶", id: 12,
    detailInfo: "寻找美味花蜜的能力非常好，离家10公里外开花的花蜜也可以找到并运回来。",
    type: [PokeType.bug, PokeType.flying],
    weak: [PokeType.fire, PokeType.flying, PokeType.rock, PokeType.electric, PokeType.ice],
    pokeImgUrl: "http://assets.pokemon.com/assets/cms2/img/pokedex/full/012.png"),
  
  Pokemon(name: "独角虫", id: 13,
    detailInfo: "嗅觉非常灵敏，可以用大大的红鼻子从讨厌的叶子中嗅出自己喜欢的叶子的味道。",
    type: [PokeType.bug, PokeType.poison],
    weak: [PokeType.fire, PokeType.flying, PokeType.rock, PokeType.psychic],
    pokeImgUrl: "http://assets.pokemon.com/assets/cms2/img/pokedex/full/013.png"),
  
  Pokemon(name: "铁壳蛹", id: 14,
    detailInfo: "挂在树上几乎一动不动是为了进化忙碌地准备着，证据是身体在逐渐变热。",
    type: [PokeType.bug, PokeType.poison],
    weak: [PokeType.fire, PokeType.flying, PokeType.rock, PokeType.psychic],
    pokeImgUrl: "http://assets.pokemon.com/assets/cms2/img/pokedex/full/014.png"),
  
  Pokemon(name: "大针蜂", id: 15,
    detailInfo: "保护领地的意识非常强，为了安全不会让任何人接近自己的巢穴，生气的话就会一起攻上来。",
    type: [PokeType.bug, PokeType.poison],
    weak: [PokeType.fire, PokeType.flying, PokeType.rock, PokeType.psychic],
    pokeImgUrl: "http://assets.pokemon.com/assets/cms2/img/pokedex/full/015.png")
]
