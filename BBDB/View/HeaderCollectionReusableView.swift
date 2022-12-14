import UIKit

// MARK: - HeaderCollectionReusableView
final class HeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "headerCollectionReusableView"
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "header"
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerLabel.frame = bounds
    }
    
    func configure(withText text: String) {
        headerLabel.text = text
        addSubview(headerLabel)
    }
}
