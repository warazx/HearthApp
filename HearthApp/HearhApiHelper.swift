//
//  HearhApiHelper.swift
//  HearthApp
//
//  Created by Christian Karlsson on 2017-03-09.
//  Copyright © 2017 Christian Karlsson. All rights reserved.
//

import Foundation
import SwiftyJSON
    
class HearthApiHelper {
    private let apiKey = "gPScgW09k8mshKfpTv5zgWLrQ7vjp1uRziAjsnl0N0L1hEHZkK"
    private let allCardsUrl = "https://omgvamp-hearthstone-v1.p.mashape.com/cards"
    private let cardSearchUrl = "https://omgvamp-hearthstone-v1.p.mashape.com/cards/search/"
    
    func searchForCards(search: String, onComplete: @escaping ([Card]) -> Void) {
        var request = URLRequest(url: URL(string: cardSearchUrl + search + "?collectible=1")!)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-Mashape-Key")
        beginTask(request) {
            onComplete($0)
        }
    }
    
    func searchForClassCollection(playerClass: String, onComplete: @escaping ([Card]) -> Void) {
        let url = URL(string: "https://omgvamp-hearthstone-v1.p.mashape.com/cards/classes/" + playerClass + "?collectible=1")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-Mashape-Key")
        beginTask(request) {
            onComplete($0)
        }
    }
    
    private func beginTask(_ request: URLRequest, onComplete: @escaping ([Card]) -> Void) {
        let task = URLSession.shared.dataTask(with: request) {
            (data : Data?, response : URLResponse?, error : Error?) in
            if let unwrappedData = data {
                let jsonData = JSON(data: unwrappedData)
                let cards = self.parseJsonData(jsonArray: jsonData)
                onComplete(cards)
            }
        }
        task.resume()
    }

    private func parseJsonData(jsonArray: JSON) -> [Card] {
        var cards : [Card] = []
        for item in jsonArray.arrayValue {
            let id = item["cardId"].stringValue
            let name = item["name"].stringValue
            let set = CardSet.selectSet(name: item["cardSet"].stringValue)
            let type = CardType.selectType(name: item["type"].stringValue)
            let rarity = CardRarity.selectRarity(name: item["rarity"].stringValue)
            let cost = item["cost"].intValue
            let attack = item["attack"].intValue
            let health = item["health"].intValue
            let playerClass = PlayerClass.selectClass(name: item["playerClass"].stringValue)
            let imageURL = item["img"].stringValue
            let text = item["text"].stringValue
            
            cards.append(Card(cardId: id, name: name, cardSet: set, type: type, rarity: rarity, cost: cost, attack: attack, health: health, class: playerClass, imageURL: imageURL, text: text))
            NSLog("Added card")
        }
        return cards
    }
}
