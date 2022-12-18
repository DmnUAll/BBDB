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
        let stackView = UIStackView()
        stackView.toAutolayout()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private let whoAmICameraButton: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutolayout()
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "makePhoto")
        imageView.backgroundColor = .bbdbWhite
        imageView.layer.borderWidth = 7
        imageView.layer.borderColor = UIColor.bbdbBlack.cgColor
        imageView.layer.cornerRadius = UIScreen.screenSize(dividedBy: 10)
        imageView.layer.masksToBounds = true
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
        delegate?.galleryButtonTapped()
    }
    
    private func addSubviews() {
        whoAmIStackView.addArrangedSubview(whoAmICameraButton)
        whoAmIStackView.addArrangedSubview(whoAmIGalleryButton)
        addSubview(whoAmIStackView)
    }
    
    private func setupConstraints() {
        let constraints = [
            whoAmICameraButton.widthAnchor.constraint(equalToConstant: UIScreen.screenSize(dividedBy: 3)),
            whoAmICameraButton.heightAnchor.constraint(equalToConstant: UIScreen.screenSize(dividedBy: 3)),
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
