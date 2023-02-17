import UIKit

// MARK: - ListViewCell
final class ListViewCell: UITableViewCell {
    
    // MARK: - Properties and Initializers
    lazy var cellMainLabel: UILabel = {
        let label = UICreator.shared.makeLabel(font: UIFont(name: "Bob'sBurgers", size: 26), andNumberOfLines: 2)
        label.toAutolayout()
        return label
    }()
    
    lazy var cellAdditionLabel: UILabel = {
        let label = UICreator.shared.makeLabel(font: UIFont(name: "Bob'sBurgers2", size: 26), andNumberOfLines: 2)
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
extension ListViewCell {
    
    private func addSubviews() {
        addSubview(cellMainLabel)
        addSubview(cellAdditionLabel)
    }
    
    private func setupConstraints() {
        let constraints = [
            cellMainLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            cellMainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cellMainLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cellAdditionLabel.topAnchor.constraint(equalTo: cellMainLabel.bottomAnchor, constant: 4),
            cellAdditionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cellAdditionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
