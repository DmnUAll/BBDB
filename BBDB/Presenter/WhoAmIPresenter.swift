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
            fatalError("CoreML model loading error")
        }

        let request = VNCoreMLRequest(model: model) { request, _ in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Photo processing error")
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
            fatalError("Request processing error")
        }
    }
}

// MARK: - WhoAmIViewDelegate
extension WhoAmIPresenter: WhoAmIViewDelegate {
    func cameraButtonTapped() {
        guard let viewController = viewController else { return }
        viewController.imagePicker.sourceType = .camera
        viewController.present(viewController.imagePicker, animated: true, completion: nil)
    }

    func galleryButtonTapped() {
        guard let viewController = viewController else { return }
        viewController.imagePicker.sourceType = .photoLibrary
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized {
                    DispatchQueue.main.async {
                        viewController.present(viewController.imagePicker, animated: true, completion: nil)
                    }
                } else {
                    return
                }
            })
        } else {
            viewController.present(viewController.imagePicker, animated: true, completion: nil)
        }
    }
}
