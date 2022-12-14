import Foundation

// MARK: - BurgerOfTheDayModel
struct BurgerOfTheDayModel: Codable {
    let id: Int
    let name, price: String
    let season, episode: Int
    let episodeURL, url: String

    enum CodingKeys: String, CodingKey {
        case id, name, price, season, episode
        case episodeURL = "episodeUrl"
        case url
    }
}

typealias BurgersOfTheDay = [BurgerOfTheDayModel]
