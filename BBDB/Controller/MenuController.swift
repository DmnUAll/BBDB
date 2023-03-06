import UIKit

// MARK: - MenuController
final class MenuController: UIViewController {

    // MARK: - Properties and Initializers
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    private var presenter: MenuPresenter?
    private var alertPresenter: AlertPresenterProtocol?
    lazy var menuView: MenuView = {
        let menuView = MenuView()
        return menuView
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UIImageView.setAsBackground(withImage: K.ImagesNames.blueBackground, to: self)
        view.addSubview(menuView)
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
            menuView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
        let alertModel = AlertModel(title: String.aboutMenu,
                                    message: InfoAlertText.aboutMenu.rawValue)
        alertPresenter?.show(alertModel: alertModel)
    }

    func showAboutAppAlert() {
        let alertModel = AlertModel(message: InfoAlertText.aboutApp.rawValue)
        alertPresenter?.show(alertModel: alertModel)
    }
}

// MARK: - String fileprivate extension
fileprivate extension String {
    static let aboutMenu = "About Menu"
}
