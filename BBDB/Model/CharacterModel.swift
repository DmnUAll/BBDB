import Foundation

// MARK: - Character
struct CharacterModel: Codable {
    let id: Int
    let name: String
    let image: String
    var imageURL: URL {
        guard let url = URL(string: image) else {
            return Bundle.main.url(forResource: K.ImagesNames.noImage, withExtension: "png")!
        }
        return url
    }
    let gender: String
    let hairColor, occupation, firstEpisode, voicedBy: String?
    let url: String
    let wikiURL: String
    let age: String?

    enum CodingKeys: String, CodingKey {
        case id, name, image, gender, hairColor, occupation, firstEpisode, voicedBy, url
        case wikiURL = "wikiUrl"
        case age
    }
}

typealias Characters = [CharacterModel]
