import Foundation

enum PlayerClass {
    case Neutral
    case Druid
    case Hunter
    case Mage
    case Paladin
    case Priest
    case Rogue
    case Shaman
    case Warlock
    case Warrior
    case Other
    
    static func selectClass(name: String) -> PlayerClass {
        switch name {
        case "Neutral": return .Neutral
        case "Druid": return .Druid
        case "Hunter": return .Hunter
        case "Mage": return .Mage
        case "Paladin": return .Paladin
        case "Priest": return .Priest
        case "Rogue": return .Rogue
        case "Shaman": return .Shaman
        case "Warlock": return .Warlock
        case "Warrior": return .Warrior
        default: return .Other
        }
    }
}
