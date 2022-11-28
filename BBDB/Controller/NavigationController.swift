import UIKit

class NavigationController: UINavigationController {
    
    weak var rootVC: InfoAlertPresenterProtocol?
    
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.popToRootViewController(animated: false)
    }
    
    private func configureNavigationController(withTitle navVCTitle: String, andCurrentMenuTitle menuTitle: String) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.tintColor = .bbdbBlack
        navigationBar.topItem?.title = navVCTitle
        navigationBar.titleTextAttributes = [.font: UIFont(name: "Bob'sBurgers", size: 30)!, .foregroundColor: UIColor.bbdbBlack]
        navigationBar.setTitleVerticalPositionAdjustment(3, for: .default)
        navigationBar.topItem?.backButtonTitle = "Back"
        let menuItems: [UIAction] = [
            UIAction(title: menuTitle, image: UIImage(systemName: "clock.badge.questionmark"), handler: { [weak self] _ in
                guard let self = self else { return }
                self.rootVC?.showCurrentControllerInfoAlert()
            }),
            UIAction(title: "About App", image: UIImage(systemName: "questionmark.app"), handler: { [weak self] _ in
                guard let self = self else { return }
                self.rootVC?.showAboutAppAlert()
            }),
        ]
        let buttonMenu = UIMenu(title: "Info", image: nil, identifier: nil, options: [], children: menuItems)
        let infoButton = UIBarButtonItem(title: "Menu", image: UIImage(systemName: "info.circle"), primaryAction: nil, menu: buttonMenu)
        navigationBar.topItem?.leftBarButtonItem = infoButton
        if rootVC is FeedController {
            navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "network"), style: .plain, target: nil, action: #selector(webButtonTapped))
        }
    }
    
    @objc private func webButtonTapped() {
        (rootVC as! FeedController).feedView.webButtonTapped()
    }
}


