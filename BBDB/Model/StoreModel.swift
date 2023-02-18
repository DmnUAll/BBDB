import Foundation

// MARK: - StoreModel
struct StoreModel: Codable {
    let id: Int
    let name: String?
    let image: String
    var imageURL: URL {
        guard let url = URL(string: image) else {
            return Bundle.main.url(forResource: K.ImagesNames.noImage, withExtension: "png")!
        }
        return url
    }
    let season, episode: Int
    let episodeURL, url: String

    enum CodingKeys: String, CodingKey {
        case id, name, image, season, episode
        case episodeURL = "episodeUrl"
        case url
    }
}

typealias Stores = [StoreModel]
