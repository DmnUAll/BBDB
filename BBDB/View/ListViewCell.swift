import UIKit

// MARK: - ListViewCell
final class ListViewCell: UITableViewCell {
    
    // MARK: - Properties and Initializers
    let cellMainLabel: UILabel = {
        let label = UILabel()
        label.toAutolayout()
        label.font = UIFont(name: "Bob'sBurgers", size: 26)
        label.textColor = .bbdbBlack
        return label
    }()
    
    let cellAdditionLabel: UILabel = {
        let label = UILabel()
        label.toAutolayout()
        label.font = UIFont(name: "Bob'sBurgers2", size: 26)
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
}

// MARK: - Helpers
extension ListViewCell {
    
    private func addSubviews() {
        addSubview(cellMainLabel)
        addSubview(cellAdditionLabel)
    }
    
    private func setupConstraints() {
        let constraints = [
            cellMainLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            cellMainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            cellMainLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            cellAdditionLabel.topAnchor.constraint(equalTo: cellMainLabel.bottomAnchor, constant: 4),
            cellAdditionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            cellAdditionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
