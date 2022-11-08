import UIKit

class NavigationController: UINavigationController {
    
    weak var rootVC: MenuController?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationController()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.rootVC = rootViewController as? MenuController
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.popToRootViewController(animated: false)
    }
    
    private func configureNavigationController() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.tintColor = .bbdbBlack
        navigationBar.topItem?.title = "Main Menu"
        navigationBar.titleTextAttributes = [.font: UIFont(name: "Bob'sBurgers", size: 30)!, .foregroundColor: UIColor.bbdbBlack]
        navigationBar.setTitleVerticalPositionAdjustment(3, for: .default)
        navigationBar.topItem?.backButtonTitle = "Back"
        let menuItems: [UIAction] = [
            UIAction(title: "About Menu", image: UIImage(systemName: "clock.badge.questionmark"), handler: { [weak self] _ in
                guard let self = self else { return }
                self.rootVC?.showAboutMenuAlert()
            }),
            UIAction(title: "About App", image: UIImage(systemName: "questionmark.app"), handler: { [weak self] _ in
                guard let self = self else { return }
                self.rootVC?.showAboutAppAlert()
            }),
        ]
        let buttonMenu = UIMenu(title: "Info", image: nil, identifier: nil, options: [], children: menuItems)
        let infoButton = UIBarButtonItem(title: "Menu", image: UIImage(systemName: "info.circle"), primaryAction: nil, menu: buttonMenu)
        navigationBar.topItem?.leftBarButtonItem = infoButton

    }
}


