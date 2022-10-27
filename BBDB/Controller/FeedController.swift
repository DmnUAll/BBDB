import UIKit

final class FeedController: UIViewController {
    
    private var appLogic: AppLogic?
    private var alertPresenter: AlertPresenterProtocol?
    
    private lazy var feedView: FeedView = {
        let feedView = FeedView()
        return feedView
    }()
        
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bbdbYellow
        view.addSubview(feedView)
        setupConstraints()
        appLogic = AppLogic(charactersLoader: CharactersLoader(), delegate: self)
        alertPresenter = AlertPresenter(delegate: self)
        appLogic?.loadData()
    }
    
    private func showNetworkError(message: String) {
        let alertModel = AlertModel(title: "Ошибка",
                                    message: message,
                                    buttonText: "Попробовать еще раз",
                                    completionHandler: { [weak self] _ in
            guard let self = self else { return }
            self.appLogic?.loadData()
        })
        alertPresenter?.show(alertModel: alertModel)
    }
    
    // MARK: Helpers

    private func setupConstraints() {
        let constraints = [
            feedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - AppLogicDelegate

extension FeedController: AppLogicDelegate {
    func didFailToLoadData(with error: Error) {
        showNetworkError(message: error.localizedDescription)
    }
    
    func didLoadDataFromServer() {
        appLogic?.requestFeed()
    }
    
    func didReceiveFeed(_ feedList: Character) {
        DispatchQueue.main.async { [ weak self ] in
            guard let self = self else { return }
            self.feedView.fillUI(with: feedList)
        }
    }
}

// MARK: - AlertPresenterDelegate

extension FeedController: AlertPresenterDelegate {
    func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
}

