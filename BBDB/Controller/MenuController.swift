import UIKit

final class MenuController: UIViewController {
    
    // MARK: - Properties and Initializers
    private var presenter: MenuPresenter?
    private var alertPresenter: AlertPresenterProtocol?
    lazy var menuView: MenuView = {
        let menuView = MenuView()
        return menuView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UIImageView.setAsBackground(withImage: "blueBackground", to: self)
        view.addSubview(menuView)
        self.title = "Main Menu"
        setupConstraints()
        presenter = MenuPresenter(viewController: self)
        alertPresenter = AlertPresenter(delegate: self)
    }
}

// MARK: - Helpers
extension MenuController {
    
    private func setupConstraints() {
        let constraints = [
            menuView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - AlertPresenterDelegate
extension MenuController: AlertPresenterDelegate {
    func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
}

// MARK: - InfoAlertPresenterProtocol
extension MenuController: InfoAlertPresenterProtocol {
    
    func showCurrentControllerInfoAlert() {
        let alertModel = AlertModel(title: "About Menu",
                                    message: InfoAlertText.aboutMenu.rawValue,
                                    buttonText: "Got it",
                                    completionHandler: nil)
        alertPresenter?.show(alertModel: alertModel)
    }
    
    func showAboutAppAlert() {
        let alertModel = AlertModel(title: "About App",
                                    message: InfoAlertText.aboutApp.rawValue,
                                    buttonText: "Got it",
                                    completionHandler: nil)
        alertPresenter?.show(alertModel: alertModel)
    }
}
