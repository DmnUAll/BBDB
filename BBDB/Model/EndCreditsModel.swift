import Foundation

// MARK: - EndCreditsModel
struct EndCreditsModel: Codable {

    let id: Int
    let image: String
    let season, episode: Int
    let episodeURL, url: String
    var imageURL: URL {
        guard let url = URL(string: image) else {
            return Bundle.main.url(forResource: K.ImagesNames.noImage, withExtension: "png")!
        }
        return url
    }

    enum CodingKeys: String, CodingKey {

        case id, image, season, episode
        case episodeURL = "episodeUrl"
        case url
    }
}

typealias EndCredits = [EndCreditsModel]
