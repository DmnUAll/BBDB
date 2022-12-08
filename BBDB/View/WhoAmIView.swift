import UIKit

protocol WhoAmIViewDelegate: AnyObject {
    func cameraButtonTapped()
    func galleryButtonTapped()
}

final class WhoAmIView: UIView {
    
    weak var delegate: WhoAmIViewDelegate?
    
    private let whoAmIStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutolayout()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private let whoAmICameraButton: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutolayout()
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(systemName: "camera")
        return imageView
    }()
    
    private let whoAmIGalleryButton: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutolayout()
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
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
    
    @objc private func cameraButtonTapped() {
        delegate?.cameraButtonTapped()
    }
    
    @objc private func galleryButtonTapped() {
        delegate?.galleryButtonTapped()
    }
    
    private func addSubviews() {
        whoAmIStackView.addArrangedSubview(whoAmICameraButton)
        whoAmIStackView.addArrangedSubview(whoAmIGalleryButton)
        addSubview(whoAmIStackView)
    }
    
    private func setupConstraints() {
        let constraints = [
            whoAmICameraButton.widthAnchor.constraint(equalToConstant: CGFloat().buttonAutoSize()),
            whoAmICameraButton.heightAnchor.constraint(equalToConstant: CGFloat().buttonAutoSize()),
            whoAmIStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            whoAmIStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setGestureRecognizers() {
        whoAmICameraButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cameraButtonTapped)))
        whoAmIGalleryButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(galleryButtonTapped)))
    }
}
