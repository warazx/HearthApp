//
//  CardSet.swift
//  HearthApp
//
//  Created by Christian Karlsson on 2017-03-09.
//  Copyright © 2017 Christian Karlsson. All rights reserved.
//

import Foundation

enum CardSet {
    case Basic
    case Classic
    case CurseOfNaxxramas
    case GoblinsVsGnomes
    case BlackrockMountain
    case GrandTournament
    case LeagueOfExplorers
    case WhispersOfTheOldGods
    case OneNightInKarazhan
    case MeanStreetsOfGadgetzan
    case Other
    
    static func selectSet(name: String) -> CardSet {
        switch name {
        case "Basic": return .Basic
        case "Classic": return .Classic
        case "Naxxramas": return .CurseOfNaxxramas
        case "Goblins vs Gnomes": return .GoblinsVsGnomes
        case "Blackrock Mountain": return .BlackrockMountain
        case "The Grand Tournament": return .GrandTournament
        case "The League of Explorers": return .LeagueOfExplorers
        case "Whispers of the Old Gods": return .WhispersOfTheOldGods
        case "Karazhan": return .OneNightInKarazhan
        case "Mean Streets of Gadgetzan": return .MeanStreetsOfGadgetzan
        default: return .Other
        }
    }
}
