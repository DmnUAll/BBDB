import UIKit

// MARK: - DetailedInfoView
final class DetailedInfoView: UIView {
    
    // MARK: - Properties and Initializers
    var infoStackView: UIStackView = {
        let stackView = UICreator.shared.makeStackView(alignment: .center, distribution: .fillEqually)
        stackView.toAutolayout()
        return stackView
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
extension DetailedInfoView {
    
    private func addSubviews() {
        addSubview(infoStackView)
        addSubview(linkTextView)
    }
    
    private func setupConstraints() {
        let constraints = [
            linkTextView.heightAnchor.constraint(equalToConstant: 40),
            linkTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            linkTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            linkTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
            infoStackView.topAnchor.constraint(equalTo: topAnchor, constant: 9),
            infoStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            infoStackView.bottomAnchor.constraint(equalTo: linkTextView.topAnchor, constant: -9)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
