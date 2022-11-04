import UIKit

final class MenuController: UIViewController {
    private var presenter: MenuPresenter?
    private var alertPresenter: AlertPresenterProtocol?
    lazy var menuView: MenuView = {
        let menuView = MenuView()
        return menuView
    }()
        
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bbdbBlue
        view.addSubview(menuView)
        setupConstraints()
        presenter = MenuPresenter(viewController: self)
        alertPresenter = AlertPresenter(delegate: self)
    }
    
    // MARK: - Helpers

    private func setupConstraints() {
        let constraints = [
            menuView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func showAboutMenuAlert() {
        let alertModel = AlertModel(title: "About Menu",
                                    message: "\nThis menu allows you to watch the full info list of any provided category.",
                                    buttonText: "Got it",
                                    completionHandler: nil)
        alertPresenter?.show(alertModel: alertModel)
    }
    
    func showAboutAppAlert() {
        let alertModel = AlertModel(title: "About App",
                                    message: """
                                    
                                    This App was made by me:
                                    https://github.com/DmnUAll
                                    
                                    Based on API:
                                    https://bobs-burgers-api-ui.herokuapp.com
                                    """,
                                    buttonText: "Got it",
                                    completionHandler: nil)
        alertPresenter?.show(alertModel: alertModel)
    }
}

// MARK: - AlertPresenterDelegate

extension MenuController: AlertPresenterDelegate {
    func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
}
