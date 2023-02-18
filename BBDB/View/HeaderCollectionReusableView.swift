import UIKit

// MARK: - HeaderCollectionReusableView
final class HeaderCollectionReusableView: UICollectionReusableView {

    private let shadowView: UIView = {
        let uiView = UIView()
        uiView.toAutolayout()
        uiView.layer.shadowColor = UIColor.black.cgColor
        uiView.layer.shadowOpacity = 1
        uiView.layer.shadowOffset = .zero
        uiView.layer.shadowRadius = 10
        return uiView
    }()

    private let headerLabel: UILabel = {
        let label = PaddingLabel(withInsets: 0, 0, 8, 8)
        label.toAutolayout()
        label.text = "header"
        label.textAlignment = .center
        label.textColor = .bbdbBlack
        label.backgroundColor = .bbdbYellow
        label.font = UIFont.appFont(.empty, withSize: UIScreen.screenHeight(dividedBy: 25))
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 3
        label.layer.borderColor = UIColor.bbdbBlack.cgColor
        label.clipsToBounds = true
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        shadowView.addSubview(headerLabel)
        addSubview(shadowView)
        let constraints = [
            headerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func configure(withText text: String) {
        headerLabel.text = text
    }
}
