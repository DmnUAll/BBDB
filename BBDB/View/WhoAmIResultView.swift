import UIKit

// MARK: - WhoAmIResultView
final class WhoAmIResultView: UIView {
    
    // MARK: - Properties and Initializers
    let whoAmIResultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutolayout()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
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
        addSubview(whoAmIResultImageView)
    }
    
    private func setupConstraints() {
        let constraints = [
            whoAmIResultImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            whoAmIResultImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            whoAmIResultImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            whoAmIResultImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
