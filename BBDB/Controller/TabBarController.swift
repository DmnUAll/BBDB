import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTabBarController()
    }
}

// MARK: - Helpers
extension TabBarController {

    private func configureTabBarController() {
        tabBar.backgroundImage = UIImage()
        tabBar.tintColor = .bbdbBlack
        tabBar.barTintColor = .bbdbBlack
        self.viewControllers = [
            configureTab(withRootController: FeedController(), title: "Feed", andImage: UIImage(systemName: "newspaper")),
            configureTab(withRootController: MenuController(), title: "Menu", andImage: UIImage(systemName: "menucard")),
            configureTab(withRootController: FavoritesController(), title: "Favorites", andImage: UIImage(systemName: "star")),
            configureTab(withRootController: WhoAmIController(), title: "Who am I?", andImage: UIImage(systemName: "person.fill.questionmark"))
        ]
    }
    
    private func configureTab(withRootController rootVC: UIViewController, title: String, andImage image: UIImage?) -> NavigationController {
        let tab = NavigationController(rootViewController: rootVC)
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: image)
        tab.tabBarItem = tabBarItem
        return tab
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // Need to add some functionality later
        print("Selected \(viewController.description)")
    }
}
