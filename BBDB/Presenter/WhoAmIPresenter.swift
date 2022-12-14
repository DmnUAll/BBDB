import UIKit
import CoreML
import Vision

final class WhoAmIPresenter {
    
    weak var viewController: WhoAmIController?
    let imagePicker = UIImagePickerController()

    init(viewController: WhoAmIController) {
        self.viewController = viewController
        viewController.whoAmIView.delegate = self
    }
    
    func detectImage(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: BBDBImageClassifier(configuration: MLModelConfiguration()).model) else {
            fatalError("CoreML model loading error")
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Photo processing error")
            }
            if let firstResult = results.first?.identifier {
                print(firstResult)
                let firstPhoto = UIImage.loadImage(withName: firstResult)
                let secondPhoto = UIImage(ciImage: image)
                guard let viewController = self.viewController else { return }
                viewController.navigationController?.pushViewController(WhoAmIResultController(firstPhoto: firstPhoto, secondPhoto: secondPhoto), animated: true)
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
        print(#function)
        guard let viewController = viewController else { return }
        viewController.imagePicker.sourceType = .camera
        viewController.present(viewController.imagePicker, animated: true, completion: nil)
    }
    
    func galleryButtonTapped() {
        print(#function)
        guard let viewController = viewController else { return }
        viewController.imagePicker.sourceType = .photoLibrary
        viewController.present(viewController.imagePicker, animated: true, completion: nil)
    }
}