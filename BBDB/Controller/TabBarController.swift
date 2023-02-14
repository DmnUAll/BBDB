import UIKit
import AVFoundation
import Network

final class TabBarController: UITabBarController {
    
    var alertPresenter: AlertPresenterProtocol?
    var player: AVAudioPlayer!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        alertPresenter = AlertPresenter(delegate: self)
        checkForInternetConnection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTabBarController()
        playSound(titleLetter: "BBDBTheme")
        player.delegate = self
    }
}

// MARK: - Helpers
extension TabBarController {
    
    private func configureTabBarController() {
        let tabBarItemAppearance = UITabBarItemAppearance(style: .stacked)
        tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Bob'sBurgers", size: 18)!,
                                                        NSAttributedString.Key.foregroundColor: UIColor.bbdbBlack]
        tabBarItemAppearance.normal.iconColor = .bbdbBlack
        tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Bob'sBurgers", size: 18)!,
                                                             NSAttributedString.Key.foregroundColor: UIColor.bbdbWhite]
        tabBarItemAppearance.selected.iconColor = .bbdbWhite
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBarAppearance.backgroundImage = UIImage(named: "bottomBun")
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        tabBar.standardAppearance = tabBarAppearance
        let iconSize = UIScreen.screenSize(dividedBy: 35)
        self.viewControllers = [
            configureTab(withRootController: FeedController(), title: "Daily Feed", andImage: UIImage(named: "feedIcon")?.resize(targetSize: CGSize(width: iconSize, height: iconSize))),
            configureTab(withRootController: MenuController(), title: "Main Menu", andImage: UIImage(named: "menuIcon")?.resize(targetSize: CGSize(width: iconSize, height: iconSize))),
            configureTab(withRootController: FavoritesController(), title: "Favorites", andImage: UIImage(named: "favoritesIcon")?.resize(targetSize: CGSize(width: iconSize, height: iconSize))),
            configureTab(withRootController: WhoAmIController(), title: "Who am I?", andImage: UIImage(named: "whoAmIIcon")?.resize(targetSize: CGSize(width: iconSize, height: iconSize))),
            configureTab(withRootController: SettingsController(), title: "Settings", andImage: UIImage(named: "settingsIcon")?.resize(targetSize: CGSize(width: iconSize, height: iconSize)))
        ]
    }
    
    private func configureTab(withRootController rootVC: UIViewController, title: String, andImage image: UIImage?) -> NavigationController {
        let tab = NavigationController(rootViewController: rootVC)
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: image)
        tab.tabBarItem = tabBarItem
        return tab
    }
    
    private func playSound(titleLetter: String) {
        let url = Bundle.main.url(forResource: titleLetter, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.volume = UserDefaultsManager.shared.appVolume
        if UserDefaultsManager.shared.appSound {
            player.play()
        }
    }
    
    private func checkForInternetConnection() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
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
        print("Selected \(viewController.description)")
    }
}

// MARK: - AVAUdioPlayerDelegate
extension TabBarController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.play()
    }
}

extension TabBarController: AlertPresenterDelegate {
    func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
}
