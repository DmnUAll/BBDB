import UIKit

class FeedPresenter {
    
    private let userDefaults = UserDefaults.standard
    private let feedLoader: NetworkDataLoading
    private var uiImageViewObserver: NSObjectProtocol?
    private var notificationsCounter = 0
    weak var viewController: FeedController?
    
    
    init(viewController: FeedController) {
        self.viewController = viewController
        feedLoader = NetworkDataLoader(link: .charactersList)
        viewController.feedView.delegate = self
        loadFiveOfTheDay()
        uiImageViewObserver = NotificationCenter.default.addObserver(
            forName: UIImageView.imageLoadedNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self = self else { return }
            self.notificationsCounter += 1
            if self.notificationsCounter == 5 {
                self.viewController?.feedView.showOrHideUI()
                NotificationCenter.default.removeObserver(self)
                self.uiImageViewObserver = nil
            }
        }
    }
}

extension FeedPresenter {
    
    private func loadData() {
        feedLoader.loadList { (result: Result<Characters, Error>) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let charactersList):
                    let fiveOfTheDay = Characters(charactersList.shuffled()[0...4])
                    self.saveUserDefaults(value: Date(), at: .date)
                    self.saveUserDefaults(value: fiveOfTheDay, at: .fiveOfTheDay)
                    self.viewController?.feedView.fillUI(with: fiveOfTheDay)
                case .failure(let error):
                    self.viewController?.showNetworkError(message: error.localizedDescription)
                }
            }
        }
    }
    
    func loadFiveOfTheDay() {
        guard let savedDate = loadUserDefaults(for: .date, as: Date.self) else {
            loadData()
            return
        }
        guard let fiveOfTheDay = loadUserDefaults(for: .fiveOfTheDay, as: Characters.self) else {
            loadData()
            return
        }
        if savedDate.dateDayString == Date().dateDayString {
            DispatchQueue.main.async {
                self.viewController?.feedView.fillUI(with:fiveOfTheDay)
            }
        } else {
            loadData()
        }
    }
    
    private func loadUserDefaults<T: Codable>(for key: Keys, as dataType: T.Type) -> T? {
        guard let data = userDefaults.data(forKey: key.rawValue),
              let count = try? JSONDecoder().decode(dataType.self, from: data) else {
            return nil
        }
        return count
    }
    
    private func saveUserDefaults<T: Codable>(value: T,at key: Keys) {
        guard let data = try? JSONEncoder().encode(value) else {
            print("Can't save data to UserDefaults")
            return
        }
        userDefaults.set(data, forKey: key.rawValue)
    }
}

private enum Keys: String {
    case fiveOfTheDay, date
}

// MARK: - FeedViewDelegate

extension FeedPresenter: FeedViewDelegate {
    
    func webButtonTapped(atPage pageIndex: Int) {
        guard let feedCharacters = loadUserDefaults(for: .fiveOfTheDay, as: Characters.self) else { return }
        let webController = WebController()
        if let webURL = URL(string: feedCharacters[pageIndex].wikiURL) {
            let request = URLRequest(url: webURL)
            webController.webView.webView.load(request)
        }
        viewController?.present(webController, animated: true)
    }
}
