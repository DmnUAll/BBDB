import UIKit

final class FeedController: UIViewController {
    
    // MARK: - Properties and Initializers
    private var presenter: FeedPresenter?
    private var alertPresenter: AlertPresenterProtocol?
    lazy var feedView: FeedView = {
        let feedView = FeedView()
        return feedView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UIImageView.setAsBackground(withImage: "yellowBackground", to: self)
        view.addSubview(feedView)
        setupConstraints()
        presenter = FeedPresenter(viewController: self)
        alertPresenter = AlertPresenter(delegate: self)
    }
}

// MARK: - Helpers
extension FeedController {
    
    private func setupConstraints() {
        let constraints = [
            feedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func showNetworkError(message: String) {
        let alertModel = AlertModel(title: "Error",
                                    message: message,
                                    buttonText: "Try again",
                                    completionHandler: { [weak self] _ in
            guard let self = self else { return }
            self.presenter?.loadFiveOfTheDay()
        })
        alertPresenter?.show(alertModel: alertModel)
    }
}

// MARK: - AlertPresenterDelegate
extension FeedController: AlertPresenterDelegate {
    
    func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
}

// MARK: - InfoAlertPresenterProtocol
extension FeedController: InfoAlertPresenterProtocol {
    
    func showCurrentControllerInfoAlert() {
        let alertModel = AlertModel(title: "About Feed",
                                    message: InfoAlertText.aboutFeed.rawValue,
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
