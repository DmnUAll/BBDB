import UIKit
class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.tintColor = .bbdbBlack
        self.tabBar.barTintColor = .bbdbBlack
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTabBarController()
    }
    
    private func configureTabBarController() {
        tabBar.backgroundImage = UIImage()
        let feedTab = FeedController()
        let feedTabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper"), selectedImage: UIImage(named: "newspaper"))
        feedTab.tabBarItem = feedTabBarItem
        
        let menuTab = NavigationController(rootViewController: MenuController())
        let menuTabBarItem = UITabBarItem(title: "Menu", image: UIImage(systemName: "menucard"), selectedImage: UIImage(named: "menucard"))
        menuTab.tabBarItem = menuTabBarItem
        
        let favoritesTab = FavoritesController()
        let favoritesTabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(named: "star"))
        favoritesTab.tabBarItem = favoritesTabBarItem
        
        self.viewControllers = [feedTab, menuTab, favoritesTab]
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.description)")
    }
}
