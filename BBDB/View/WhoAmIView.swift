import UIKit

// MARK: - WhoAmIViewDelegate protocol
protocol WhoAmIViewDelegate: AnyObject {
    func cameraButtonTapped()
    func galleryButtonTapped()
}

// MARK: - WhoAmIView
final class WhoAmIView: UIView {

    // MARK: - Properties and Initializers
    weak var delegate: WhoAmIViewDelegate?

    private let whoAmIStackView: UIStackView = {
        let stackView = UICreator.shared.makeStackView(distribution: .fillEqually, addingSpacing: 8)
        stackView.toAutolayout()
        return stackView
    }()

    private let whoAmICameraButton: UIImageView = {
        let imageView = UICreator.shared.makeImageView(borderWidth: 7, dividerForCornerRadius: 10)
        imageView.toAutolayout()
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: K.ImagesNames.makePhoto)
        imageView.accessibilityIdentifier = K.AccessibilityIdentifiers.makePhoto
        return imageView
    }()

    private let whoAmIGalleryButton: UIImageView = {
        let imageView = UICreator.shared.makeImageView(borderWidth: 7, dividerForCornerRadius: 10)
        imageView.toAutolayout()
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: K.ImagesNames.choosePhoto)
        imageView.accessibilityIdentifier = K.AccessibilityIdentifiers.choosePhoto
        return imageView
    }()

    private lazy var linkTextView: UITextView = UICreator.shared.makeTextViewWithLink()

    override init(frame: CGRect) {
        super.init(frame: frame)
        toAutolayout()
        addSubviews()
        setupConstraints()
        setGestureRecognizers()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension WhoAmIView {

    @objc private func cameraButtonTapped() {
        whoAmICameraButton.backgroundColor = .bbdbGray
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [weak self] in
            guard let self = self else { return }
            self.whoAmICameraButton.backgroundColor = .bbdbWhite
        })
        delegate?.cameraButtonTapped()
    }

    @objc private func galleryButtonTapped() {
        whoAmIGalleryButton.backgroundColor = .bbdbGray
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [weak self] in
            guard let self = self else { return }
            self.whoAmIGalleryButton.backgroundColor = .bbdbWhite
        })
        delegate?.galleryButtonTapped()
    }

    private func addSubviews() {
        whoAmIStackView.addArrangedSubview(whoAmICameraButton)
        whoAmIStackView.addArrangedSubview(whoAmIGalleryButton)
        addSubview(whoAmIStackView)
        addSubview(linkTextView)
    }

    private func setupConstraints() {
        let constraints = [
            linkTextView.heightAnchor.constraint(equalToConstant: 40),
            linkTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            linkTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            linkTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
            whoAmICameraButton.widthAnchor.constraint(equalToConstant: UIScreen.screenHeight(dividedBy: 3)),
            whoAmICameraButton.heightAnchor.constraint(equalToConstant: UIScreen.screenHeight(dividedBy: 3)),
            whoAmIStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            whoAmIStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setGestureRecognizers() {
        whoAmICameraButton.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                       action: #selector(cameraButtonTapped)))
        whoAmIGalleryButton.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                        action: #selector(galleryButtonTapped)))
    }
}
