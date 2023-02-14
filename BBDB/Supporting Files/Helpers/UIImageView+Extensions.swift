import UIKit

extension UIImageView {
    
//    static var imageLoadedNotification: Notification.Name {
//        Notification.Name(rawValue: "UIImageViewFinishedImageLoading")
//    }

    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
//                        NotificationCenter.default.post(name: UIImageView.imageLoadedNotification,
//                                                        object: self)
                    }
                }
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


