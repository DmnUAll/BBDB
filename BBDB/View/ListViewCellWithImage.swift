import UIKit

final class ListViewCellWithImage: UITableViewCell {
    
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutolayout()
        imageView.backgroundColor = .bbdbWhite
        imageView.layer.borderColor = UIColor.bbdbBlack.cgColor
        imageView.layer.borderWidth = 3
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = UIScreen.screenSize(dividedBy: 40)
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
            cellImageView.heightAnchor.constraint(equalToConstant: UIScreen.screenSize(dividedBy: 10)),
            cellImageView.widthAnchor.constraint(equalToConstant: UIScreen.screenSize(dividedBy: 10)),
            cellImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            cellImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 4),
            cellLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            cellLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
