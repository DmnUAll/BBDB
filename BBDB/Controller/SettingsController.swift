import UIKit

final class SettingsController: UIViewController {
    
    // MARK: - Properties and Initializers
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    private var presenter: SettingsPresenter?
    private var alertPresenter: AlertPresenterProtocol?
    lazy var settingsView: SettingsView = {
        let settingsView = SettingsView()
        return settingsView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UIImageView.setAsBackground(withImage: "blueBackground", to: self)
        view.addSubview(settingsView)
        self.title = "Settings"
        setupConstraints()
        presenter = SettingsPresenter(viewController: self)
        alertPresenter = AlertPresenter(delegate: self)
    }
}

// MARK: - Helpers
extension SettingsController {
    
    private func setupConstraints() {
        let constraints = [
            settingsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - AlertPresenterDelegate
extension SettingsController: AlertPresenterDelegate {
    func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
}

// MARK: - InfoAlertPresenterProtocol
extension SettingsController: InfoAlertPresenterProtocol {
    
    func showCurrentControllerInfoAlert() {
        let alertModel = AlertModel(title: "About Settings",
                                    message: InfoAlertText.aboutSettings.rawValue,
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
