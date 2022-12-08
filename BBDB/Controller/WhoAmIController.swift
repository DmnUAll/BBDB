import UIKit
import CoreML
import Vision

final class WhoAmIController: UIViewController {
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
        print(#function)

        UIImageView().setAsBackgroundImage(named: "blueBackground", to: self)
        self.title = "Who am I?"
        view.addSubview(whoAmIView)
        setupConstraints()
        presenter = WhoAmIPresenter(viewController: self)
        alertPresenter = AlertPresenter(delegate: self)
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.modalPresentationStyle = .popover
    }
    
    // MARK: - Helpers

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
                                    message: "\nThis section allows you to know - which character from 'Bob's Burgers' suits you.",
                                    buttonText: "Got it",
                                    completionHandler: nil)
        alertPresenter?.show(alertModel: alertModel)
    }
    
    func showAboutAppAlert() {
        let alertModel = AlertModel(title: "About App",
                                    message: """
                                    
                                    This App was made by me:
                                    https://github.com/DmnUAll
                                    
                                    Based on API:
                                    https://bobs-burgers-api-ui.herokuapp.com
                                    """,
                                    buttonText: "Got it",
                                    completionHandler: nil)
        alertPresenter?.show(alertModel: alertModel)
    }
}

extension WhoAmIController: UINavigationControllerDelegate { }

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
