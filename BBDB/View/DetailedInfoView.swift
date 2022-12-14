import UIKit
import CoreData

// MARK: - DetailedInfoView
final class DetailedInfoView: UIView {
    
    // MARK: - Properties and Initializers
    var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutolayout()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        return stackView
    }()
    
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
    }
    
    private func setupConstraints() {
        let constraints = [
            infoStackView.topAnchor.constraint(equalTo: topAnchor),
            infoStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            infoStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func fillUI(with data: Codable) {
        let labelStack = makeStackView(axis: .vertical,
                                       alignment: .center,
                                       distribution: .fillProportionally,
                                       backgroundColor: .bbdbSkin)
        labelStack.spacing = 0
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
        let labelStack = makeStackView(axis: .vertical,
                                       alignment: .center,
                                       distribution: .fillProportionally,
                                       backgroundColor: .bbdbSkin)
        labelStack.spacing = 0
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
    
    private func makeStackView(axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment, distribution: UIStackView.Distribution, backgroundColor: UIColor) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.backgroundColor = backgroundColor
        stackView.spacing = 4
        return stackView
    }
    
    private func makeImageView(withImage url: URL) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UIScreen.screenSize(dividedBy: 30)
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.bbdbBlack.cgColor
        imageView.backgroundColor = .bbdbWhite
        imageView.load(url: url)
        imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        return imageView
    }
    
    private func makeLabel(text: String, font: String, color: UIColor, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: font, size: 23)
        label.textColor = color
        label.textAlignment = alignment
        label.numberOfLines = 0
        label.text = text
        return label
    }
    
    private func makeLabelStack(leadingText: String, trailingText: String) -> UIStackView {
        let stackView = makeStackView(axis: .horizontal,
                                      alignment: .fill,
                                      distribution: .fillEqually,
                                      backgroundColor: .bbdbBlue)
        stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        stackView.layer.borderWidth = 2
        stackView.layer.borderColor = UIColor.bbdbGray.cgColor
        stackView.addArrangedSubview(makeLabel(text: leadingText, font: "Bob'sBurgers2", color: .bbdbBlack, alignment: .center))
        stackView.addArrangedSubview(makeLabel(text: trailingText, font: "Bob'sBurgers", color: .bbdbBlack, alignment: .left))
        return stackView
    }
}
