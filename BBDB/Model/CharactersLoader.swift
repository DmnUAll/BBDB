import Foundation

protocol CharactersLoading {
    func loadCharacters(handler: @escaping (Result<Character, Error>) -> Void)
}

struct CharactersLoader: CharactersLoading {
    private let networkClient = NetworkClient()
    private var charactersListUrl: URL {
        guard let url = URL(string: "https://bobsburgers-api.herokuapp.com/characters/") else {
            preconditionFailure("Unable to charactersListUrl")
        }
        return url
    }
    
    func loadCharacters(handler: @escaping (Result<Character, Error>) -> Void) {
        networkClient.fetch(url: charactersListUrl) { result in
            do {
                let data = try result.get()
                let decodedData = try JSONDecoder().decode(Character.self, from: data)
                handler(.success(decodedData))
            } catch let error {
                handler(.failure(error))
            }
        }
    }
}
