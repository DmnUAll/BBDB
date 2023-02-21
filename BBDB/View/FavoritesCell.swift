import UIKit

// MARK: - FavoritesCell
final class FavoritesCell: UICollectionViewCell {

    // MARK: - Properties and Initializers
    let cellImageView: UIImageView = {
        let imageView = UICreator.shared.makeImageView(borderWidth: 2, borderColor: .bbdbBrown)
        imageView.toAutolayout()
        return imageView
    }()

    let cellLabel: UILabel = {
        let label = PaddingLabel(withInsets: 3, 3, 3, 3)
        label.toAutolayout()
        label.font = UIFont.appFont(.filled, withSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.textColor = .bbdbBlack
        label.layer.borderColor = UIColor.bbdbBrown.cgColor
        label.layer.borderWidth = 2
        label.backgroundColor = .bbdbWhite
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Helpers
extension FavoritesCell {

    private func addSubviews() {
        addSubview(cellImageView)
        addSubview(cellLabel)
    }

    private func setupConstraints() {
        let constraints = [
            cellImageView.heightAnchor.constraint(equalToConstant: UIScreen.screenHeight(dividedBy: 8)),
            cellImageView.widthAnchor.constraint(equalTo: cellImageView.heightAnchor, multiplier: 1),
            cellImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cellLabel.widthAnchor.constraint(equalToConstant: UIScreen.screenHeight(dividedBy: 6)),
            cellLabel.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: 4),
            cellLabel.centerXAnchor.constraint(equalTo: cellImageView.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
