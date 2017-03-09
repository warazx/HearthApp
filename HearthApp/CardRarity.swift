//
//  CardRarity.swift
//  HearthApp
//
//  Created by Christian Karlsson on 2017-03-09.
//  Copyright © 2017 Christian Karlsson. All rights reserved.
//

import Foundation

enum CardRarity {
    case Common
    case Rare
    case Epic
    case Legendary
    case Other
    
    static func selectRarity(name: String) -> CardRarity {
        switch name {
        case "Common": return .Common
        case "Rare": return .Rare
        case "Epic": return .Epic
        case "Legendary": return .Legendary
        default: return .Other
        }
    }
}
