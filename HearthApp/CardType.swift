import Foundation

enum CardType {
    case Minion
    case Spell
    case Weapon
    case Other
    
    static func selectType(name: String) -> CardType {
        switch name {
        case "Minion": return .Minion
        case "Spell": return .Spell
        case "Weapon": return .Weapon
        default: return .Other
        }
    }
}
