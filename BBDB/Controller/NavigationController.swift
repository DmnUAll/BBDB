import UIKit

// MARK: - NavigationController
final class NavigationController: UINavigationController {

    // MARK: - Properties and Initializers
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }

    private weak var rootVC: InfoAlertPresenterProtocol?

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)

        if let viewController = rootViewController as? FeedController {
            self.rootVC = viewController
            configureNavigationController(withTitle: "Feed: 5 of the day", andCurrentMenuTitle: "About Feed")
        }
        if let viewController = rootViewController as? MenuController {
            self.rootVC = viewController
            configureNavigationController(withTitle: "Main Menu", andCurrentMenuTitle: "About Menu")
        }
        if let viewController = rootViewController as? FavoritesController {
            self.rootVC = viewController
            configureNavigationController(withTitle: "Favorites", andCurrentMenuTitle: "About Favorites")
        }
        if let viewController = rootViewController as? WhoAmIController {
            self.rootVC = viewController
            configureNavigationController(withTitle: "Who am I?", andCurrentMenuTitle: "About 'Who am I?'")
        }
        if let viewController = rootViewController as? SettingsController {
            self.rootVC = viewController
            configureNavigationController(withTitle: "Settings", andCurrentMenuTitle: "About Settings")
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        self.popToRootViewController(animated: false)
    }
}

// MARK: - Helpers
extension NavigationController {

    private func configureNavigationController(withTitle navVCTitle: String, andCurrentMenuTitle menuTitle: String) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.titleTextAttributes = [
            .font: UIFont.appFont(.filled, withSize: UIScreen.screenHeight(dividedBy: 25)),
            .foregroundColor: UIColor.bbdbBrown
        ]
        navBarAppearance.titlePositionAdjustment.vertical = 5
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundImage = UIImage(named: K.ImagesNames.topBun)
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationBar.tintColor = .bbdbBrown
        navigationBar.topItem?.title = navVCTitle
        navigationBar.topItem?.backButtonTitle = "Back"
        let iconSize = UIScreen.screenHeight(dividedBy: 25)
        let currentModuleInfo = UIAction(
            title: menuTitle,
            subtitle: "Info about current screen",
            image: UIImage(named: K.IconsNames.currentScreenInfo)?.resize(targetSize: CGSize(width: iconSize,
                                                                                             height: iconSize)),
            handler: { [weak self] _ in
                guard let self = self else { return }
                self.rootVC?.showCurrentControllerInfoAlert()
            })
        currentModuleInfo.accessibilityIdentifier = K.AccessibilityIdentifiers.moduleInfo
        let appInfo = UIAction(
            title: "About App",
            subtitle: "Info about app",
            image: UIImage(named: K.IconsNames.appInfo)?.resize(targetSize: CGSize(width: iconSize,
                                                                                   height: iconSize)),
            handler: { [weak self] _ in
                guard let self = self else { return }
                self.rootVC?.showAboutAppAlert()
            })
        appInfo.accessibilityIdentifier = K.AccessibilityIdentifiers.appInfo
        let menuItems: [UIAction] = [currentModuleInfo, appInfo]
        let buttonMenu = UIMenu(title: "Info", image: nil, identifier: nil, options: [], children: menuItems)
        let infoButton = UIBarButtonItem(
            title: "Menu",
            image: UIImage(named: K.IconsNames.info)?.resize(targetSize: CGSize(width: iconSize, height: iconSize)),
            primaryAction: nil, menu: buttonMenu)
        navigationBar.topItem?.leftBarButtonItem = infoButton
        if rootVC is FeedController {
            navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(named: K.IconsNames.network)?.resize(targetSize: CGSize(width: iconSize,
                                                                                       height: iconSize)),
                style: .plain,
                target: nil,
                action: #selector(webButtonTapped))
        }
    }

    @objc private func webButtonTapped() {
        (rootVC as? FeedController)?.feedView.webButtonTapped()
    }
}
