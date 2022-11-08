import UIKit

final class DetailedInfoView: UIView {
    
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
    
    func fillUI(with data: CharacterModel) {
        let labelStack = makeStackView(axis: .vertical,
                                       alignment: .center,
                                       distribution: .fillProportionally,
                                       backgroundColor: .bbdbSkin)
        labelStack.spacing = 0
        labelStack.clipsToBounds = true
        labelStack.layer.borderColor = UIColor.bbdbBlack.cgColor
        labelStack.layer.borderWidth = 3
        labelStack.layer.cornerRadius = CGFloat().cornerRadiusAutoSize()
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
}

extension DetailedInfoView {
    
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
        imageView.layer.cornerRadius = CGFloat().cornerRadiusAutoSize()
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


