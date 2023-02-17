import UIKit
import CoreData

// MARK: - DetailedInfoView
final class DetailedInfoView: UIView {
    
    // MARK: - Properties and Initializers
    var infoStackView: UIStackView = {
        let stackView = UICreator.shared.makeStackView(alignment: .center, distribution: .fillEqually)
        stackView.toAutolayout()
        return stackView
    }()
    private lazy var linkTextView: UITextView = UICreator.shared.makeTextViewWithLink()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        toAutolayout()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension DetailedInfoView {
    
    private func addSubviews() {
        addSubview(infoStackView)
        addSubview(linkTextView)
    }
    
    private func setupConstraints() {
        let constraints = [
            linkTextView.heightAnchor.constraint(equalToConstant: 40),
            linkTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            linkTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            linkTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
            infoStackView.topAnchor.constraint(equalTo: topAnchor, constant: 9),
            infoStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            infoStackView.bottomAnchor.constraint(equalTo: linkTextView.topAnchor, constant: -9)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func fillUI(with data: Codable) {
        let labelStack = UICreator.shared.makeStackView(alignment: .center, distribution: .fillProportionally, addingSpacing: 0)
        labelStack.clipsToBounds = true
        labelStack.layer.borderColor = UIColor.bbdbBlack.cgColor
        labelStack.layer.borderWidth = 3
        labelStack.layer.cornerRadius = UIScreen.screenSize(dividedBy: 30)
        if let data = data as? CharacterModel {
            infoStackView.addArrangedSubview(makeImageView(withImage: data.imageURL))
            infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Name:", trailingText: data.name))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Gender:", trailingText: data.gender))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Age:", trailingText: data.age ?? "Unknown"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Hair color:", trailingText: data.hairColor ?? "Undefined"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Occupation:", trailingText: data.occupation ?? "Unknown"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "1st appearance:", trailingText: data.firstEpisode ?? "Undefined"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Voiced by:", trailingText: data.voicedBy ?? "Undefined"))
        }
        if let data = data as? EpisodeModel {
            infoStackView.addArrangedSubview(makeImageView(withImage: Bundle.main.url(forResource: "noImage", withExtension: "png")!))
            infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Episode ID:", trailingText: "\(data.id)"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Name:", trailingText: data.name))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Season: \(data.season):", trailingText: "Episode: \(data.episode)"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Air date:", trailingText: data.airDate))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Total viewers:", trailingText: data.totalViewers))
        }
        if let data = data as? StoreModel {
            infoStackView.addArrangedSubview(makeImageView(withImage: data.imageURL))
            infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Name:", trailingText: data.name ?? "Unknown"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "1st ppearance:", trailingText: "S\(data.season) E\(data.episode)"))
        }
        if let data = data as? PestControlTruckModel {
            infoStackView.addArrangedSubview(makeImageView(withImage: data.imageURL))
            infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Name:", trailingText: data.name ?? "Unknown"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "1st ppearance:", trailingText: "Season \(data.season)"))
        }
        if let data = data as? EndCreditsModel {
            infoStackView.addArrangedSubview(makeImageView(withImage: data.imageURL))
            infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Season:", trailingText: "\(data.season)"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Episode:", trailingText: "\(data.episode)"))
        }
        if let data = data as? BurgerOfTheDayModel {
            infoStackView.addArrangedSubview(makeImageView(withImage: Bundle.main.url(forResource: "noImage", withExtension: "png")!))
            infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Burger's name:", trailingText: data.name))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Burger's price:", trailingText: data.price))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Season \(data.season):", trailingText: "Episode: \(data.episode)"))
        }
    }
    
    func fillUI(with data: NSManagedObject) {
        let labelStack = UICreator.shared.makeStackView(alignment: .center, distribution: .fillProportionally, addingSpacing: 0)
        labelStack.clipsToBounds = true
        labelStack.layer.borderColor = UIColor.bbdbBlack.cgColor
        labelStack.layer.borderWidth = 3
        labelStack.layer.cornerRadius = UIScreen.screenSize(dividedBy: 30)
        if let data = data as? CDCharacter {
            infoStackView.addArrangedSubview(makeImageView(withImage: data.imageURL ?? Bundle.main.url(forResource: "noImage", withExtension: "png")!))
            infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Name:", trailingText: data.name ?? "No Name"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Gender:", trailingText: data.gender ?? "Undefined"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Age:", trailingText: data.age ?? "Unknown"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Hair color:", trailingText: data.hairColor ?? "Undefined"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Occupation:", trailingText: data.occupation ?? "Unknown"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "1st appearance:", trailingText: data.firstEpisode ?? "Undefined"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Voiced by:", trailingText: data.voicedBy ?? "Undefined"))
        }
        if let data = data as? CDEpisode {
            infoStackView.addArrangedSubview(makeImageView(withImage: Bundle.main.url(forResource: "noImage", withExtension: "png")!))
            infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Episode ID:", trailingText: "\(data.id)"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Name:", trailingText: data.name ?? "No Name"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Season: \(data.season):", trailingText: "Episode: \(data.episode)"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Air date:", trailingText: data.airDate ?? "Unknown"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Total viewers:", trailingText: data.totalViewers ?? "Unknown"))
        }
        if let data = data as? CDStore {
            infoStackView.addArrangedSubview(makeImageView(withImage: data.imageURL ?? Bundle.main.url(forResource: "noImage", withExtension: "png")!))
            infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Name:", trailingText: data.name ?? "Unknown"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "1st ppearance:", trailingText: "S\(data.season) E\(data.episode)"))
        }
        if let data = data as? CDTruck {
            infoStackView.addArrangedSubview(makeImageView(withImage: data.imageURL ?? Bundle.main.url(forResource: "noImage", withExtension: "png")!))
            infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Name:", trailingText: data.name ?? "Unknown"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "1st ppearance:", trailingText: "Season \(data.season)"))
        }
        if let data = data as? CDCredits {
            infoStackView.addArrangedSubview(makeImageView(withImage: data.imageURL ?? Bundle.main.url(forResource: "noImage", withExtension: "png")!))
            infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Season:", trailingText: "\(data.season)"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Episode:", trailingText: "\(data.episode)"))
        }
        if let data = data as? CDBurger {
            infoStackView.addArrangedSubview(makeImageView(withImage: Bundle.main.url(forResource: "noImage", withExtension: "png")!))
            infoStackView.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Burger's name:", trailingText: data.name ?? "No Name"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Burger's price:", trailingText: data.price ?? "Unknown"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Season \(data.season):", trailingText: "Episode: \(data.episode)"))
        }
    }
    
    private func makeImageView(withImage url: URL) -> UIImageView {
        let imageView = UICreator.shared.makeImageView(withImage: url)
        imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        return imageView
    }
    
    private func makeLabelStack(leadingText: String, trailingText: String) -> UIStackView {
        let stackView = UICreator.shared.makeLabelStack(leadingText: leadingText, trailingText: trailingText, backgroundColor: .bbdbRed, intersectionColor: .bbdbSkin)
        stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        return stackView
    }
}
