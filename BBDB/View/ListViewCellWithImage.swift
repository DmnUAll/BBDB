import UIKit

// MARK: - ListViewCellWithImage
final class ListViewCellWithImage: UITableViewCell {
    
    // MARK: - Properties and Initializers
    let cellImageView: UIImageView = {
        let imageView = UICreator.shared.makeImageView()
        imageView.toAutolayout()
        return imageView
    }()
    
    let cellLabel: UILabel = {
        let label = UICreator.shared.makeLabel(font: UIFont.appFont(.filled, withSize: 26), alignment: .natural, andNumberOfLines: 2)
        label.toAutolayout()
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
}

// MARK: - Helpers
extension ListViewCellWithImage {
    
    private func addSubviews() {
        addSubview(cellImageView)
        addSubview(cellLabel)
    }
    
    private func setupConstraints() {
        let constraints = [
            cellImageView.heightAnchor.constraint(equalToConstant: UIScreen.screenHeight(dividedBy: 10)),
            cellImageView.widthAnchor.constraint(equalToConstant: UIScreen.screenHeight(dividedBy: 10)),
            cellImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cellImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 20),
            cellLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cellLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
