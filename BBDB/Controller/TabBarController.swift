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
        self.delegate = self
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
                title: "Daily Feed",
                andImage: UIImage(
                    named: K.IconsNames.feed)?.resize(targetSize: CGSize(width: iconSize, height: iconSize))),
            configureTab(
                withRootController: MenuController(),
                title: "Main Menu",
                andImage: UIImage(
                    named: K.IconsNames.menu)?.resize(targetSize: CGSize(width: iconSize, height: iconSize))),
            configureTab(
                withRootController: FavoritesController(),
                title: "Favorites",
                andImage: UIImage(
                    named: K.IconsNames.favorites)?.resize(targetSize: CGSize(width: iconSize, height: iconSize))),
            configureTab(
                withRootController: WhoAmIController(),
                title: "Who am I?",
                andImage: UIImage(
                    named: K.IconsNames.whoAmI)?.resize(targetSize: CGSize(width: iconSize, height: iconSize))),
            configureTab(
                withRootController: SettingsController(),
                title: "Settings",
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
                    let alertModel = AlertModel(title: "Error",
                                                message: "No Internet connection!",
                                                buttonText: "Ok",
                                                completionHandler: nil)
                    self.alertPresenter?.show(alertModel: alertModel)
                }
            }
        }
        monitor.start(queue: queue)
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // Need to fix the bug!!!
        // Select the MainMenu tab and choose any category
        // Select any item from tableView
        // Select any other tab from tabViewController
        // The index of selected tab is valid but there is no selection for this tab (untill tapped twice)
        print(selectedIndex)
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
