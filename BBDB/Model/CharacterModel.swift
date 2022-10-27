import Foundation

// MARK: - Character

struct CharacterModel: Codable {
    let id: Int
    let name: String
    let image: String
    var imageURL: URL {
        guard let url = URL(string: image) else {
            return Bundle.main.url(forResource: "noImage", withExtension: "png")!
        }
        return url
    }
    let gender: String
    let hairColor, occupation, firstEpisode, voicedBy: String?
    let url: String
    let wikiURL: String
    let relatives: [Relative]
    let age: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, image, gender, hairColor, occupation, firstEpisode, voicedBy, url
        case wikiURL = "wikiUrl"
        case relatives, age
    }
}

// MARK: - Relative
struct Relative: Codable {
    let name: String
    let wikiURL: String?
    let relationship: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case name
        case wikiURL = "wikiUrl"
        case relationship, url
    }
}

typealias Character = [CharacterModel]
