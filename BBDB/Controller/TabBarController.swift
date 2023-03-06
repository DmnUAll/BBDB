import UIKit
import AVFoundation
import Network
import Kingfisher

// MARK: - TabBarController
final class TabBarController: UITabBarController {

    // MARK: - Properties and Initializers
    private var alertPresenter: AlertPresenterProtocol?
    var player: AVAudioPlayer?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureKFCache()
        alertPresenter = AlertPresenter(delegate: self)
        checkForInternetConnection()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTabBarController()
        playSound(K.SoundsNames.mainTheme)
        player?.delegate = self
    }
}

// MARK: - Helpers
extension TabBarController {

    private func configureKFCache() {
        let cache = ImageCache.default
        cache.memoryStorage.config.countLimit = 100
        cache.diskStorage.config.sizeLimit = 1000 * 1000 * 100
        cache.diskStorage.config.expiration = .never
        cache.memoryStorage.config.cleanInterval = 86400
    }

    private func configureTabBarController() {
        let tabBarItemAppearance = UITabBarItemAppearance(style: .stacked)
        tabBarItemAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.appFont(.filled, withSize: 18),
            NSAttributedString.Key.foregroundColor: UIColor.bbdbBrown
        ]
        tabBarItemAppearance.normal.iconColor = .bbdbBrown
        tabBarItemAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.appFont(.filled, withSize: 18),
            NSAttributedString.Key.foregroundColor: UIColor.bbdbGray
        ]
        tabBarItemAppearance.selected.iconColor = .bbdbGray

        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBarAppearance.backgroundImage = UIImage(named: K.ImagesNames.bottomBun)
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        tabBar.standardAppearance = tabBarAppearance
        let iconSize = UIScreen.screenHeight(dividedBy: 35)
        self.viewControllers = [
            configureTab(
                withRootController: FeedController(),
                title: String.feedTab,
                andImage: UIImage(
                    named: K.IconsNames.feed)?.resize(targetSize: CGSize(width: iconSize, height: iconSize))),
            configureTab(
                withRootController: MenuController(),
                title: String.menuTab,
                andImage: UIImage(
                    named: K.IconsNames.menu)?.resize(targetSize: CGSize(width: iconSize, height: iconSize))),
            configureTab(
                withRootController: FavoritesController(),
                title: String.favoritesTab,
                andImage: UIImage(
                    named: K.IconsNames.favorites)?.resize(targetSize: CGSize(width: iconSize, height: iconSize))),
            configureTab(
                withRootController: WhoAmIController(),
                title: String.whoAmITab,
                andImage: UIImage(
                    named: K.IconsNames.whoAmI)?.resize(targetSize: CGSize(width: iconSize, height: iconSize))),
            configureTab(
                withRootController: SettingsController(),
                title: String.settingsTab,
                andImage: UIImage(
                    named: K.IconsNames.settings)?.resize(targetSize: CGSize(width: iconSize, height: iconSize)))
        ]
        tabBar.accessibilityIdentifier = K.AccessibilityIdentifiers.tabBar
    }

    private func configureTab(withRootController rootVC: UIViewController,
                              title: String,
                              andImage image: UIImage?
    ) -> NavigationController {
        let tab = NavigationController(rootViewController: rootVC)
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: image)
        tab.tabBarItem = tabBarItem
        return tab
    }

    private func playSound(_ name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3"),
              let playerWithAudio = try? AVAudioPlayer(contentsOf: url) else { return }
        player = playerWithAudio
        player?.volume = UserDefaultsManager.shared.appVolume
        if UserDefaultsManager.shared.appSound {
            player?.play()
        }
    }

    private func checkForInternetConnection() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetConnectionMonitor")

        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                return
            } else {
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    let alertModel = AlertModel(title: String.error,
                                                message: String.connectionError,
                                                buttonText: String.okTitle,
                                                completionHandler: nil)
                    self.alertPresenter?.show(alertModel: alertModel)
                }
            }
        }
        monitor.start(queue: queue)
    }
}

// MARK: - AVAUdioPlayerDelegate
extension TabBarController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.play()
    }
}

// MARK: - AlertPresenterDelegate
extension TabBarController: AlertPresenterDelegate {
    func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
}

// MARK: - String fileprivate extension
fileprivate extension String {
    static let error = "Error"
    static let connectionError = "No Internet connection!"
    static let okTitle = "Ok"
    static let feedTab =  "Daily Feed"
    static let menuTab = "Main Menu"
    static let favoritesTab = "Favorites"
    static let whoAmITab = "Who am I?"
    static let settingsTab = "Settings"
}
