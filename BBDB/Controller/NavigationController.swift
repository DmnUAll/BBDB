import UIKit

final class NavigationController: UINavigationController {
    
    // MARK: - Properties and Initializers
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    
    private weak var rootVC: InfoAlertPresenterProtocol?
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        if let vc = rootViewController as? FeedController {
            self.rootVC = vc
            configureNavigationController(withTitle: "Feed: 5 of the day", andCurrentMenuTitle: "About Feed")
        }
        if let vc = rootViewController as? MenuController {
            self.rootVC = vc
            configureNavigationController(withTitle: "Main Menu", andCurrentMenuTitle: "About Menu")
        }
        if let vc = rootViewController as? FavoritesController {
            self.rootVC = vc
            configureNavigationController(withTitle: "Favorites", andCurrentMenuTitle: "About Favorites")
        }
        if let vc = rootViewController as? WhoAmIController {
            self.rootVC = vc
            configureNavigationController(withTitle: "Who am I?", andCurrentMenuTitle: "About 'Who am I?'")

        }
        if let vc = rootViewController as? SettingsController {
            self.rootVC = vc
            configureNavigationController(withTitle: "Settings", andCurrentMenuTitle: "About Settings")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewWillDisappear(_ animated: Bool) {
        self.popToRootViewController(animated: false)
    }
}

// MARK: - Helpers
extension NavigationController {
    
    private func configureNavigationController(withTitle navVCTitle: String, andCurrentMenuTitle menuTitle: String) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.titleTextAttributes = [.font: UIFont(name: "Bob'sBurgers", size: UIScreen.screenSize(dividedBy: 25))!, .foregroundColor: UIColor.bbdbBlack]
        navBarAppearance.titlePositionAdjustment.vertical = 5
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundImage = UIImage(named: "topBun")
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationBar.tintColor = .bbdbBlack
        navigationBar.topItem?.title = navVCTitle
        navigationBar.topItem?.backButtonTitle = "Back"
        let iconSize = UIScreen.screenSize(dividedBy: 25)
        let menuItems: [UIAction] = [
            UIAction(title: menuTitle, subtitle: "Info about current screen", image: UIImage(named: "currentScreenInfoIcon")?.resize(targetSize: CGSize(width: iconSize, height: iconSize)), handler: { [weak self] _ in
                guard let self = self else { return }
                self.rootVC?.showCurrentControllerInfoAlert()
            }),
            UIAction(title: "About App", subtitle: "Info about app", image: UIImage(named: "appInfoIcon")?.resize(targetSize: CGSize(width: iconSize, height: iconSize)), handler: { [weak self] _ in
                guard let self = self else { return }
                self.rootVC?.showAboutAppAlert()
            }),
        ]
        let buttonMenu = UIMenu(title: "Info", image: nil, identifier: nil, options: [], children: menuItems)
        let infoButton = UIBarButtonItem(title: "Menu", image: UIImage(named: "infoIcon")?.resize(targetSize: CGSize(width: iconSize, height: iconSize)), primaryAction: nil, menu: buttonMenu)
        navigationBar.topItem?.leftBarButtonItem = infoButton
        if rootVC is FeedController {
            navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "networkIcon")?.resize(targetSize: CGSize(width: iconSize, height: iconSize)), style: .plain, target: nil, action: #selector(webButtonTapped))
        }
    }
    
    @objc private func webButtonTapped() {
        (rootVC as! FeedController).feedView.webButtonTapped()
    }
}
