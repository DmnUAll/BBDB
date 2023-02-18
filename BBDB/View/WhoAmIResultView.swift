import UIKit

// MARK: - WhoAmIResultView
final class WhoAmIResultView: UIView {
    
    // MARK: - Properties and Initializers
    let whoAmIResultImageView: UIImageView = {
        let imageView = UICreator.shared.makeImageView(backgroundColor: .bbdbBlack.withAlphaComponent(0.8))
        imageView.toAutolayout()
        return imageView
    }()
    
    private lazy var linkTextView: UITextView = UICreator.shared.makeTextViewWithLink()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        toAutolayout()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension WhoAmIResultView {
    
    private func addSubviews() {
        addSubview(whoAmIResultImageView)
        addSubview(linkTextView)
    }
    
    private func setupConstraints() {
        let constraints = [
            linkTextView.heightAnchor.constraint(equalToConstant: 40),
            linkTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            linkTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            linkTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
            whoAmIResultImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            whoAmIResultImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            whoAmIResultImageView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 8),
            whoAmIResultImageView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 8),
            whoAmIResultImageView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -8),
            whoAmIResultImageView.bottomAnchor.constraint(lessThanOrEqualTo: linkTextView.topAnchor, constant: -8)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
