import UIKit
import Kingfisher

extension UIImageView {

    static var imageLoadedNotification: Notification.Name {
        Notification.Name(rawValue: "UIImageViewFinishedImageLoading")
    }
    
    func load(url: URL) {
        self.kf.setImage(with: url, placeholder: UIImage(named: "placeholderIcon")) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: UIImageView.imageLoadedNotification,
                                                    object: self)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func setAsBackground(withImage imageName: String, to viewController: UIViewController) {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.image = UIImage(named: imageName)
        viewController.view.insertSubview(backgroundImage, at: 0)
    }
}
