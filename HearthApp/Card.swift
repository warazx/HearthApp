//
//  Card.swift
//  HearthApp
//
//  Created by Christian Karlsson on 2017-03-09.
//  Copyright © 2017 Christian Karlsson. All rights reserved.
//

import Foundation

class Card {
    let cardId : String
    let name : String
    let cardSet : CardSet
    let type : CardType
    let rarity : CardRarity
    let cost : Int
    let attack : Int
    let health : Int
    let text : String
    let playerClass : PlayerClass
    let imageURL : URL
    
    
    init(cardId: String, name: String, cardSet: CardSet, type: CardType, rarity: CardRarity, cost: Int, attack: Int, health: Int, class playerClass: PlayerClass, imageURL: String, text: String) {
        self.cardId = cardId
        self.name = name
        self.cardSet = cardSet
        self.type = type
        self.rarity = rarity
        self.cost = cost
        self.attack = attack
        self.health = health
        self.playerClass = playerClass
        self.imageURL = URL(string: imageURL)!
        self.text = text
    }
}
