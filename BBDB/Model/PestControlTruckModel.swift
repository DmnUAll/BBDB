import Foundation

// MARK: - PestControlTruckModel
struct PestControlTruckModel: Codable {

    let id: Int
    let name: String?
    let image: String
    var imageURL: URL {
        guard let url = URL(string: image) else {
            return Bundle.main.url(forResource: K.ImagesNames.noImage, withExtension: "png")!
        }
        return url
    }
    let season: Int
    let episode: String?
    let url: String
}

typealias PestControlTrucks = [PestControlTruckModel]
