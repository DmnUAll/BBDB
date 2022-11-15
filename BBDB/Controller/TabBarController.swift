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
        
        let testTab = TestController()
        let testTabBarItem = UITabBarItem(title: "Test", image: UIImage(systemName: "testtube.2"), selectedImage: UIImage(named: "testtube.2"))
        testTab.tabBarItem = testTabBarItem
        
        self.viewControllers = [feedTab, menuTab, testTab]
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.description)")
    }
}
