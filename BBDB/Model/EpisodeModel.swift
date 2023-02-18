import Foundation

// MARK: - EpisodeModel
struct EpisodeModel: Codable {

    let id: Int
    let name, productionCode, airDate: String
    let season, episode: Int
    let totalViewers: String
    let url, wikiURL: String

    enum CodingKeys: String, CodingKey {

        case id, name, productionCode, airDate, season, episode, totalViewers, url
        case wikiURL = "episodeUrl"
    }
}

typealias Episodes = [EpisodeModel]
