import UIKit
import CoreML
import Vision
import Photos

// MARK: - WhoAmIPresenter
final class WhoAmIPresenter {

    // MARK: - Properties and Initializers
    private weak var viewController: WhoAmIController?
    private let imagePicker = UIImagePickerController()

    init(viewController: WhoAmIController) {
        self.viewController = viewController
        viewController.whoAmIView.delegate = self
    }
}

// MARK: - Helpers
extension WhoAmIPresenter {

    func detectImage(image: CIImage) {
        guard let model = try? VNCoreMLModel(
            for: BBDBImageClassifier(configuration: MLModelConfiguration()).model
        ) else {
            fatalError(String.modelLoadingError)
        }

        let request = VNCoreMLRequest(model: model) { request, _ in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError(String.photoProcessingError)
            }
            if let firstResult = results.first?.identifier {
                let firstPhoto = UIImage.loadImage(withName: firstResult)
                let secondPhoto = UIImage(ciImage: image)
                guard let viewController = self.viewController else { return }
                viewController.navigationController?.pushViewController(
                    WhoAmIResultController(firstPhoto: firstPhoto, secondPhoto: secondPhoto),
                    animated: true)
            }
        }

        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            fatalError(String.requestProcessingError)
        }
    }

    private func makeAlert(withMessage message: String) -> UIAlertController {
        let alert = UIAlertController(title: String.alertTitle, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!,
                                      options: [:],
                                      completionHandler: nil)
        }
        alert.addAction(cancelAction)
        alert.addAction(settingsAction)
        return alert
    }
}

// MARK: - WhoAmIViewDelegate
extension WhoAmIPresenter: WhoAmIViewDelegate {
    func cameraButtonTapped() {
        guard let viewController = viewController else { return }
        viewController.imagePicker.sourceType = .camera
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            DispatchQueue.main.async {
                viewController.present(viewController.imagePicker, animated: true, completion: nil)
            }
        case .denied:
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                viewController.present(self.makeAlert(withMessage: String.alertMessageCamera), animated: true)
            }
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] success in
                guard let self else { return }
                if success {
                    DispatchQueue.main.async {
                        viewController.present(viewController.imagePicker, animated: true, completion: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        viewController.present(self.makeAlert(withMessage: String.alertMessageCamera), animated: true)
                    }
                }
            }
        default:
            return
        }
    }

    // swiftlint:disable:next cyclomatic_complexity
    func galleryButtonTapped() {
        guard let viewController = viewController else { return }
        viewController.imagePicker.sourceType = .photoLibrary
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            DispatchQueue.main.async {
                viewController.present(viewController.imagePicker, animated: true, completion: nil)
            }
        case .denied, .restricted:
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                viewController.present(self.makeAlert(withMessage: String.alertMessageGallery), animated: true)
            }
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { [weak self] status in
                guard let self else { return }
                switch status {
                case .authorized:
                    DispatchQueue.main.async {
                        viewController.present(viewController.imagePicker, animated: true, completion: nil)
                    }
                case .denied, .restricted:
                    DispatchQueue.main.async {
                        viewController.present(self.makeAlert(withMessage: String.alertMessageGallery), animated: true)
                    }
                case .notDetermined:
                    return
                default:
                    return
                }
            }
        default:
            return
        }
    }
}

// MARK: - String fileprivate extension
fileprivate extension String {
    static let alertTitle = "Access Denied!"
    static let alertMessageCamera = "Please give an access to camera!"
    static let alertMessageGallery = "Please give an access to photo gallery!"
    static let modelLoadingError = "CoreML model loading error"
    static let photoProcessingError = "Photo processing error"
    static let requestProcessingError = "Request processing error"
}
