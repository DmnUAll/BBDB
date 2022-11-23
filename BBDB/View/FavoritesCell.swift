import UIKit

final class FavoritesCell: UICollectionViewCell {
    
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutolayout()
        imageView.backgroundColor = .bbdbWhite
        imageView.layer.borderColor = UIColor.bbdbBlack.cgColor
        imageView.layer.borderWidth = 3
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = CGFloat().cornerRadiusAutoSize(divider: 40)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let cellLabel: UILabel = {
        let label = UILabel()
        label.toAutolayout()
        label.font = UIFont(name: "Bob'sBurgers", size: 26)
        label.textColor = .bbdbBlack
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
    
    private func addSubviews() {
        addSubview(cellImageView)
        addSubview(cellLabel)
    }
    
    private func setupConstraints() {
        let constraints = [
            cellImageView.heightAnchor.constraint(equalToConstant: CGFloat().cornerRadiusAutoSize(divider: 10)),
            cellImageView.widthAnchor.constraint(equalToConstant: CGFloat().cornerRadiusAutoSize(divider: 10)),
            cellImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cellImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellLabel.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: 4),
            cellLabel.centerXAnchor.constraint(equalTo: cellImageView.centerXAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}