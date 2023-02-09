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
        checkInternetConnection()
        
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
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Bob'sBurgers", size: 18)!], for: .normal)
        tabBar.tintColor = .bbdbWhite
        tabBar.unselectedItemTintColor = .bbdbBlack
        tabBar.backgroundColor = .clear.withAlphaComponent(0.3)
        self.viewControllers = [
            configureTab(withRootController: FeedController(), title: "Feed", andImage: UIImage(systemName: "newspaper")),
            configureTab(withRootController: MenuController(), title: "Menu", andImage: UIImage(systemName: "menucard")),
            configureTab(withRootController: FavoritesController(), title: "Favorites", andImage: UIImage(systemName: "star")),
            configureTab(withRootController: WhoAmIController(), title: "Who am I?", andImage: UIImage(systemName: "person.fill.questionmark")),
            configureTab(withRootController: SettingsController(), title: "App Settings", andImage: UIImage(systemName: "gear"))
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
    
    private func checkInternetConnection() {
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
        // Need to add some functionality later
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
