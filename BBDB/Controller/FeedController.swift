import UIKit

// MARK: - FeedController
final class FeedController: UIViewController {

    // MARK: - Properties and Initializers
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    private var presenter: FeedPresenter?
    private var alertPresenter: AlertPresenterProtocol?
    lazy var feedView: FeedView = {
        let feedView = FeedView()
        return feedView
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UIImageView.setAsBackground(withImage: K.ImagesNames.yellowBackground, to: self)
        view.addSubview(feedView)
        setupConstraints()
        presenter = FeedPresenter(viewController: self)
        alertPresenter = AlertPresenter(delegate: self)
        showOrHideUI()
    }
}

// MARK: - Helpers
extension FeedController {

    private func setupConstraints() {
        let constraints = [
            feedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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

    func fillUI(with feedList: Characters) {
        let width = feedView.feedScrollView.bounds.width
        for index in 0...4 {
            let character = feedList[index]
            let scrollViewPage = UICreator.shared.makeStackView(alignment: .center,
                                                                distribution: .fillEqually)
            scrollViewPage.frame = CGRect(x: width * CGFloat(index),
                                          y: 0,
                                          width: width,
                                          height: feedView.feedScrollView.bounds.height)
            let labelStack = UICreator.shared.makeStackView(distribution: .fillProportionally)
            labelStack.spacing = 0
            labelStack.clipsToBounds = true
            labelStack.toAutolayout()
            labelStack.widthAnchor.constraint(equalToConstant: width - 32).isActive = true
            labelStack.layer.borderColor = UIColor.bbdbBrown.cgColor
            labelStack.layer.borderWidth = 3
            labelStack.layer.cornerRadius = UIScreen.screenHeight(dividedBy: 30)
            let imageView = UICreator.shared.makeImageView(withImage: character.imageURL, borderColor: .bbdbGreen)
            imageView.widthAnchor.constraint(equalToConstant: feedView.feedScrollView.bounds.width - 32).isActive = true
            scrollViewPage.addArrangedSubview(imageView)
            scrollViewPage.addArrangedSubview(labelStack)
            let uiCreator = UICreator.shared
            labelStack.addArrangedSubview(uiCreator.makeLabelStack(leadingText: "Name:",
                                                                   trailingText: character.name))
            labelStack.addArrangedSubview(uiCreator.makeLabelStack(leadingText: "Gender:",
                                                                   trailingText: character.gender))
            labelStack.addArrangedSubview(uiCreator.makeLabelStack(leadingText: "Age:",
                                                                   trailingText: character.age ?? "Unknown"))
            labelStack.addArrangedSubview(uiCreator.makeLabelStack(leadingText: "Hair color:",
                                                                   trailingText: character.hairColor ?? "Undefined"))
            labelStack.addArrangedSubview(uiCreator.makeLabelStack(leadingText: "Occupation:",
                                                                   trailingText: character.occupation ?? "Unknown"))
            labelStack.addArrangedSubview(uiCreator.makeLabelStack(leadingText: "1st appearance:",
                                                                   trailingText: character.firstEpisode ?? "Undefined"))
            labelStack.addArrangedSubview(uiCreator.makeLabelStack(leadingText: "Voiced by:",
                                                                   trailingText: character.voicedBy ?? "Undefined"))
            feedView.feedScrollView.addSubview(scrollViewPage)
        }
    }

    func showOrHideUI() {
        if feedView.feedActivityIndicator.isAnimating {
            feedView.feedActivityIndicator.stopAnimating()
        } else {
            feedView.feedActivityIndicator.startAnimating()
        }
        feedView.feedScrollView.isHidden.toggle()
        feedView.feedPageControl.isHidden.toggle()
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
