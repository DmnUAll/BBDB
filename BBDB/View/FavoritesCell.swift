import UIKit

// MARK: - FavoritesCell
final class FavoritesCell: UICollectionViewCell {
    
    // MARK: - Properties and Initializers
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutolayout()
        imageView.backgroundColor = .bbdbWhite
        imageView.layer.borderColor = UIColor.bbdbBlack.cgColor
        imageView.layer.borderWidth = 2
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = UIScreen.screenSize(dividedBy: 40)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let cellLabel: UILabel = {
        let label = PaddingLabel(withInsets: 3, 3, 3, 3)
        label.toAutolayout()
        label.font = UIFont(name: "Bob'sBurgers", size: 18)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.textColor = .bbdbBlack
        label.layer.borderColor = UIColor.bbdbBlack.cgColor
        label.layer.borderWidth = 1
        label.backgroundColor = .bbdbWhite
        label.layer.cornerRadius = 5
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
            cellImageView.heightAnchor.constraint(equalToConstant: UIScreen.screenSize(dividedBy: 10)),
            cellImageView.widthAnchor.constraint(equalTo: cellImageView.heightAnchor, multiplier: 1),
            cellImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cellImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cellLabel.widthAnchor.constraint(equalToConstant: UIScreen.screenSize(dividedBy: 6)),
            cellLabel.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: 4),
            cellLabel.centerXAnchor.constraint(equalTo: cellImageView.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
