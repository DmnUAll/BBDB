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
        let alertModel = AlertModel(title: String.error,
                                    message: message,
                                    buttonText: String.tryAgain,
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
            labelStack.addArrangedSubview(uiCreator.makeLabelStack(
                leadingText: String.name,
                trailingText: character.name))
            labelStack.addArrangedSubview(uiCreator.makeLabelStack(
                leadingText: String.gender,
                trailingText: character.gender))
            labelStack.addArrangedSubview(uiCreator.makeLabelStack(
                leadingText: String.age,
                trailingText: character.age ?? String.unknown))
            labelStack.addArrangedSubview(uiCreator.makeLabelStack(
                leadingText: String.hairColor,
                trailingText: character.hairColor ?? String.undefined))
            labelStack.addArrangedSubview(uiCreator.makeLabelStack(
                leadingText: String.occupation,
                trailingText: character.occupation ?? String.unknown))
            labelStack.addArrangedSubview(uiCreator.makeLabelStack(
                leadingText: String.firstAppearance,
                trailingText: character.firstEpisode ?? String.undefined))
            labelStack.addArrangedSubview(uiCreator.makeLabelStack(
                leadingText: String.voicedBy,
                trailingText: character.voicedBy ?? String.undefined))
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
        let alertModel = AlertModel(title: String.aboutFeed,
                                    message: InfoAlertText.aboutFeed.rawValue)
        alertPresenter?.show(alertModel: alertModel)
    }

    func showAboutAppAlert() {
        let alertModel = AlertModel(message: InfoAlertText.aboutApp.rawValue)
        alertPresenter?.show(alertModel: alertModel)
    }
}

// MARK: - String fileprivate extension
fileprivate extension String {
    static let error = "Error"
    static let tryAgain = "Try again"
    static let aboutFeed = "About Feed"
    static let undefined = "Undefined"
    static let unknown = "Unknown"
    static let name = "Name:"
    static let gender = "Gender:"
    static let age = "Age:"
    static let hairColor = "Hair color:"
    static let occupation = "Occupation:"
    static let firstAppearance = "1st appearance:"
    static let voicedBy = "Voiced by:"
}
