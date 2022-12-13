import UIKit


final class WhoAmIResultController: UIViewController {
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
        UIImageView.setAsBackground(withImage: "blueBackground", to: self)
        self.title = "'Who am I' Result"
        view.addSubview(whoAmIResultView)
        setupConstraints()
    }
    
    // MARK: - Helpers

    private func setupConstraints() {
        let constraints = [
            whoAmIResultView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            whoAmIResultView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whoAmIResultView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            whoAmIResultView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
