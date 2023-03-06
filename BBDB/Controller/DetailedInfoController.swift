import UIKit
import CoreData

// MARK: - DetailedInfoController
final class DetailedInfoController: UIViewController {

    // MARK: - Properties and Initializers
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    private var presenter: DetailedInfoPresenter?
    lazy var detailedInfoView: DetailedInfoView = {
        let detailedInfoView = DetailedInfoView()
        return detailedInfoView
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailedInfoView)
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if view.backgroundColor == .bbdbGreen {
            UIImageView.setAsBackground(withImage: K.ImagesNames.greenBackground, to: self)
        } else {
            UIImageView.setAsBackground(withImage: K.ImagesNames.blueBackground, to: self)
        }
    }
}

// MARK: - Helpers
extension DetailedInfoController {

    @objc private func webButtonTapped() {
        presenter?.webButtonTapped()
    }

    private func setupConstraints() {
        let constraints = [
            detailedInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailedInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailedInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailedInfoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func addWebButton(withLink link: String) {
        presenter = DetailedInfoPresenter(viewController: self)
        presenter?.link = link
        let iconSize = UIScreen.screenHeight(dividedBy: 25)
        let webButton = UIBarButtonItem(
            image: UIImage(named: K.IconsNames.network)?.resize(targetSize: CGSize(width: iconSize, height: iconSize)),
            style: .plain,
            target: self,
            action: #selector(webButtonTapped))
        navigationItem.rightBarButtonItem = webButton
    }

    // swiftlint:disable:next function_body_length
    func fillUI(with data: Codable) {
        let imageUrl = Bundle.main.url(forResource: K.ImagesNames.noImage, withExtension: "png")!
        let labelStack = UICreator.shared.makeStackView(alignment: .center,
                                                        distribution: .fillProportionally,
                                                        addingSpacing: 0)
        labelStack.clipsToBounds = true
        labelStack.layer.borderColor = UIColor.bbdbSkin.cgColor
        labelStack.layer.borderWidth = 3
        labelStack.layer.cornerRadius = UIScreen.screenHeight(dividedBy: 30)
        if let data = data as? CharacterModel {
            detailedInfoView.infoStackView.addArrangedSubview(makeImageView(withImage: data.imageURL))
            detailedInfoView.infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.name,
                                                         trailingText: data.name))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.gender,
                                                         trailingText: data.gender))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.age,
                                                         trailingText: data.age ?? String.unknown))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.hairColor,
                                                         trailingText: data.hairColor ?? String.undefined))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.occupation,
                                                         trailingText: data.occupation ?? String.unknown))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.firstAppearance,
                                                         trailingText: data.firstEpisode ?? String.undefined))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.voicedBy,
                                                         trailingText: data.voicedBy ?? String.undefined))
        }
        if let data = data as? EpisodeModel {
            detailedInfoView.infoStackView.addArrangedSubview(makeImageView(withImage: imageUrl))
            detailedInfoView.infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.episodeID,
                                                         trailingText: "\(data.id)"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.name,
                                                         trailingText: data.name))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "\(String.season) \(data.season):",
                                                         trailingText: "\(String.episode) \(data.episode)"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.airDate,
                                                         trailingText: data.airDate))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.totalViewers,
                                                         trailingText: data.totalViewers))
        }
        if let data = data as? StoreModel {
            detailedInfoView.infoStackView.addArrangedSubview(makeImageView(withImage: data.imageURL))
            detailedInfoView.infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.name,
                                                         trailingText: data.name ?? String.unknown))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.firstAppearance,
                                                         trailingText: "S\(data.season) E\(data.episode)"))
        }
        if let data = data as? PestControlTruckModel {
            detailedInfoView.infoStackView.addArrangedSubview(makeImageView(withImage: data.imageURL))
            detailedInfoView.infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.name,
                                                         trailingText: data.name ?? String.unknown))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.firstAppearance,
                                                         trailingText: "\(String.season) \(data.season)"))
        }
        if let data = data as? EndCreditsModel {
            detailedInfoView.infoStackView.addArrangedSubview(makeImageView(withImage: data.imageURL))
            detailedInfoView.infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.season,
                                                         trailingText: "\(data.season)"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.episode,
                                                         trailingText: "\(data.episode)"))
        }
        if let data = data as? BurgerOfTheDayModel {
            detailedInfoView.infoStackView.addArrangedSubview(makeImageView(withImage: imageUrl))
            detailedInfoView.infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.burgersName,
                                                         trailingText: data.name))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.burgersPrice,
                                                         trailingText: data.price))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "\(String.season) \(data.season)",
                                                         trailingText: "\(String.episode) \(data.episode)"))
        }
    }

    // swiftlint:disable:next function_body_length
    func fillUI(with data: NSManagedObject) {
        let imageUrl = Bundle.main.url(forResource: K.ImagesNames.noImage, withExtension: "png")!
        let labelStack = UICreator.shared.makeStackView(alignment: .center,
                                                        distribution: .fillProportionally,
                                                        addingSpacing: 0)
        labelStack.clipsToBounds = true
        labelStack.layer.borderColor = UIColor.bbdbSkin.cgColor
        labelStack.layer.borderWidth = 3
        labelStack.layer.cornerRadius = UIScreen.screenHeight(dividedBy: 30)
        if let data = data as? CDCharacter {
            detailedInfoView.infoStackView.addArrangedSubview(makeImageView(withImage: data.imageURL ?? imageUrl))
            detailedInfoView.infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.name,
                                                         trailingText: data.name ?? String.noName))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.gender,
                                                         trailingText: data.gender ?? String.undefined))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.age,
                                                         trailingText: data.age ?? String.unknown))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.hairColor,
                                                         trailingText: data.hairColor ?? String.undefined))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.occupation,
                                                         trailingText: data.occupation ?? String.unknown))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.firstAppearance,
                                                         trailingText: data.firstEpisode ?? String.undefined))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.voicedBy,
                                                         trailingText: data.voicedBy ?? String.undefined))
        }
        if let data = data as? CDEpisode {
            detailedInfoView.infoStackView.addArrangedSubview(makeImageView(withImage: imageUrl))
            detailedInfoView.infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.episodeID,
                                                         trailingText: "\(data.id)"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.name,
                                                         trailingText: data.name ?? String.noName))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "\(String.season) \(data.season):",
                                                         trailingText: "\(String.episode) \(data.episode)"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.airDate,
                                                         trailingText: data.airDate ?? String.unknown))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.totalViewers,
                                                         trailingText: data.totalViewers ?? String.unknown))
        }
        if let data = data as? CDStore {
            detailedInfoView.infoStackView.addArrangedSubview(makeImageView(withImage: data.imageURL ?? imageUrl))
            detailedInfoView.infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.name,
                                                         trailingText: data.name ?? String.unknown))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.firstAppearance,
                                                         trailingText: "S\(data.season) E\(data.episode)"))
        }
        if let data = data as? CDTruck {
            detailedInfoView.infoStackView.addArrangedSubview(makeImageView(withImage: data.imageURL ?? imageUrl))
            detailedInfoView.infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.name,
                                                         trailingText: data.name ?? String.unknown))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.firstAppearance,
                                                         trailingText: "\(String.season) \(data.season)"))
        }
        if let data = data as? CDCredits {
            detailedInfoView.infoStackView.addArrangedSubview(makeImageView(withImage: data.imageURL ?? imageUrl))
            detailedInfoView.infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.season,
                                                         trailingText: "\(data.season)"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.episode,
                                                         trailingText: "\(data.episode)"))
        }
        if let data = data as? CDBurger {
            detailedInfoView.infoStackView.addArrangedSubview(makeImageView(withImage: imageUrl))
            detailedInfoView.infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.burgersName,
                                                         trailingText: data.name ?? String.noName))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: String.burgersPrice,
                                                         trailingText: data.price ?? String.unknown))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "\(String.season) \(data.season)",
                                                         trailingText: "\(String.episode) \(data.episode)"))
        }
    }

    private func makeImageView(withImage url: URL) -> UIImageView {
        let imageView = UICreator.shared.makeImageView(withImage: url, borderColor: .bbdbYellow)
        imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        return imageView
    }

    private func makeLabelStack(leadingText: String, trailingText: String) -> UIStackView {
        let stackView = UICreator.shared.makeLabelStack(leadingText: leadingText,
                                                        trailingText: trailingText,
                                                        backgroundColor: .bbdbRed,
                                                        intersectionColor: .bbdbSkin)
        stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        return stackView
    }
}

// MARK: - String fileprivate extension
fileprivate extension String {
    static let undefined = "Undefined"
    static let unknown = "Unknown"
    static let noName = "No Name"
    static let season = "Season:"
    static let episode = "Episode:"
    static let name = "Name:"
    static let gender = "Gender:"
    static let age = "Age:"
    static let hairColor = "Hair color:"
    static let occupation = "Occupation:"
    static let firstAppearance = "1st appearance:"
    static let voicedBy = "Voiced by:"
    static let episodeID = "Episode ID:"
    static let airDate = "Air date:"
    static let totalViewers = "Total viewers:"
    static let burgersName = "Burger's name:"
    static let burgersPrice = "Burger's price:"
}
