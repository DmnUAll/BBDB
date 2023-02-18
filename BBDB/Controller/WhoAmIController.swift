import UIKit

// MARK: - WhoAmIController
final class WhoAmIController: UIViewController {
    
    // MARK: - Properties and Initializers
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    private var presenter: WhoAmIPresenter?
    private var alertPresenter: AlertPresenterProtocol?
    let imagePicker = UIImagePickerController()
    lazy var whoAmIView: WhoAmIView = {
        let whoAmIView = WhoAmIView()
        return whoAmIView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UIImageView.setAsBackground(withImage: K.ImagesNames.redBackground, to: self)
        self.title = "Who am I?"
        view.addSubview(whoAmIView)
        setupConstraints()
        presenter = WhoAmIPresenter(viewController: self)
        alertPresenter = AlertPresenter(delegate: self)
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.modalPresentationStyle = .popover
    }
}

// MARK: - Helpers
extension WhoAmIController {
    
    private func setupConstraints() {
        let constraints = [
            whoAmIView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            whoAmIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whoAmIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            whoAmIView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - AlertPresenterDelegate
extension WhoAmIController: AlertPresenterDelegate {
    func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
}

// MARK: - InfoAlertPresenterProtocol
extension WhoAmIController: InfoAlertPresenterProtocol {
    
    func showCurrentControllerInfoAlert() {
        let alertModel = AlertModel(title: "About 'Who am I?'",
                                    message: InfoAlertText.aboutWhoAmI.rawValue,
                                    buttonText: "Got it",
                                    completionHandler: nil)
        alertPresenter?.show(alertModel: alertModel)
    }
    
    func showAboutAppAlert() {
        let alertModel = AlertModel(title: "About App",
                                    message: InfoAlertText.aboutApp.rawValue,
                                    buttonText: "Got it",
                                    completionHandler: nil)
        alertPresenter?.show(alertModel: alertModel)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension WhoAmIController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            guard let ciimage = CIImage(image: userPickedImage.fixOrientation()) else {
                fatalError("Can't convert UIImage в CIImage")
            }
            presenter?.detectImage(image: ciimage)
        }
        imagePicker.dismiss(animated: true)
    }
}

// MARK: - UINavigationControllerDelegate
extension WhoAmIController: UINavigationControllerDelegate { }
