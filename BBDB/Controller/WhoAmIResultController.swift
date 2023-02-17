import UIKit

final class WhoAmIResultController: UIViewController {
    
    // MARK: - Properties and Initializers
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    let imagePicker = UIImagePickerController()
    lazy var whoAmIResultView: WhoAmIResultView = {
        let whoAmIResultView = WhoAmIResultView()
        return whoAmIResultView
    }()
    
    convenience init(firstPhoto: UIImage, secondPhoto: UIImage) {
        self.init()
        whoAmIResultView.whoAmIResultImageView.image = firstPhoto.mergeImage(with: secondPhoto)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UIImageView.setAsBackground(withImage: "redBackground", to: self)
        self.title = "'Who am I' Result"
        view.addSubview(whoAmIResultView)
        setupConstraints()
        addShareButton()
    }
}

// MARK: - Helpers
extension WhoAmIResultController {
    
    @objc private func shareButtonTapped() {
        let image = whoAmIResultView.whoAmIResultImageView.image
        guard let image else { return }
        let resizedImage = image.resize(targetSize: CGSize(width: image.size.width / 1.6, height: image.size.height / 1.6))
        let text = "Hey! Look at which character from \"Bob's Burgers\" I look like!"
        let activityViewController = UIActivityViewController(activityItems: [resizedImage, text],
                                                              applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop,
                                                        UIActivity.ActivityType.postToFacebook]
        present(activityViewController, animated: true, completion: nil)
    }
    
    private func setupConstraints() {
        let constraints = [
            whoAmIResultView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            whoAmIResultView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whoAmIResultView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            whoAmIResultView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addShareButton() {
        let iconSize = UIScreen.screenSize(dividedBy: 35)
        let shareButton = UIBarButtonItem(image: UIImage(named: "shareIcon")?.resize(targetSize: CGSize(width: iconSize, height: iconSize)), style: .plain, target: self, action: #selector(shareButtonTapped))
        navigationItem.rightBarButtonItem = shareButton
    }
}
