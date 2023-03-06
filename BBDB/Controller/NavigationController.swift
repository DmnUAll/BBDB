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
            configureNavigationController(withTitle: String.feedVCTitle, andCurrentMenuTitle: String.feedMenuTitle)
        }
        if let viewController = rootViewController as? MenuController {
            self.rootVC = viewController
            configureNavigationController(withTitle: String.menuVCTitle, andCurrentMenuTitle: String.menuMenuTitle)
        }
        if let viewController = rootViewController as? FavoritesController {
            self.rootVC = viewController
            configureNavigationController(withTitle: String.favoritesVCTitle,
                                          andCurrentMenuTitle: String.favoritesMenuTitle)
        }
        if let viewController = rootViewController as? WhoAmIController {
            self.rootVC = viewController
            configureNavigationController(withTitle: String.whoAmIVCTitle,
                                          andCurrentMenuTitle: String.whoAmIMenuTitle)
        }
        if let viewController = rootViewController as? SettingsController {
            self.rootVC = viewController
            configureNavigationController(withTitle: String.settingsVCTitle,
                                          andCurrentMenuTitle: String.settingsMenuTitle)
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
        navigationBar.topItem?.backButtonTitle = String.backButtonTitle
        let iconSize = UIScreen.screenHeight(dividedBy: 25)
        let currentModuleInfo = UIAction(
            title: menuTitle,
            subtitle: String.currentMenuSubtitle,
            image: UIImage(named: K.IconsNames.currentScreenInfo)?.resize(targetSize: CGSize(width: iconSize,
                                                                                             height: iconSize)),
            handler: { [weak self] _ in
                guard let self = self else { return }
                self.rootVC?.showCurrentControllerInfoAlert()
            })
        currentModuleInfo.accessibilityIdentifier = K.AccessibilityIdentifiers.moduleInfo
        let appInfo = UIAction(
            title: String.appMenuTitle,
            subtitle: String.appMenuSubtitle,
            image: UIImage(named: K.IconsNames.appInfo)?.resize(targetSize: CGSize(width: iconSize,
                                                                                   height: iconSize)),
            handler: { [weak self] _ in
                guard let self = self else { return }
                self.rootVC?.showAboutAppAlert()
            })
        appInfo.accessibilityIdentifier = K.AccessibilityIdentifiers.appInfo
        let menuItems: [UIAction] = [currentModuleInfo, appInfo]
        let buttonMenu = UIMenu(title: String.infoTitle, image: nil, identifier: nil, options: [], children: menuItems)
        let infoButton = UIBarButtonItem(
            title: String.infoButtonTitle,
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

// MARK: - String fileprivate extension
fileprivate extension String {
    static let backButtonTitle = "Back"
    static let currentMenuSubtitle = "Info about current screen"
    static let appMenuTitle = "About App"
    static let appMenuSubtitle = "Info about app"
    static let infoTitle = "Info"
    static let infoButtonTitle = "Menu"
    static let feedVCTitle = "Feed: 5 of the day"
    static let menuVCTitle = "Main Menu"
    static let favoritesVCTitle = "Favorites"
    static let whoAmIVCTitle = "Who am I?"
    static let settingsVCTitle = "Settings"
    static let feedMenuTitle = "About Feed"
    static let menuMenuTitle = "About Menu"
    static let favoritesMenuTitle = "About Favorites"
    static let whoAmIMenuTitle = "About 'Who am I?'"
    static let settingsMenuTitle = "About Settings"
}
