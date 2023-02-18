import Foundation

// MARK: - NetworkDataLoading protocol
protocol NetworkDataLoading {

    func loadList<T: Codable>(handler: @escaping (Result<T, Error>) -> Void)
}

// MARK: - NetworkDataLoader
struct NetworkDataLoader: NetworkDataLoading {

    private let networkClient = NetworkClient()
    private let link: Link
    private var listUrl: URL {
        guard let url = URL(string: link.rawValue) else {
            preconditionFailure("Unable to create listUrl")
        }
        return url
    }

    init(link: Link) {
        self.link = link
    }

    func loadList<T: Codable>(handler: @escaping (Result<T, Error>) -> Void) {
        networkClient.fetch(url: listUrl) { result in
            do {
                let data = try result.get()
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                handler(.success(decodedData))
            } catch let error {
                handler(.failure(error))
            }
        }
    }
}

enum Link: String {

    case charactersList = "https://bobsburgers-api.herokuapp.com/characters/"
    case episodesList = "https://bobsburgers-api.herokuapp.com/episodes/"
    case nextDoorStoresList = "https://bobsburgers-api.herokuapp.com/storeNextDoor/"
    case pestControllTrucksList = "https://bobsburgers-api.herokuapp.com/pestControlTruck/"
    case endCreditsList = "https://bobsburgers-api.herokuapp.com/endCreditsSequence/"
    case burgersOfTheDayList = "https://bobsburgers-api.herokuapp.com/burgerOfTheDay/"
}
