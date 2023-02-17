import UIKit
import Kingfisher

final class SplashController: UIViewController {
    
    // MARK: - Properties and Initializers
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    private let splashImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.screenSize(dividedBy: 4), height: UIScreen.screenSize(dividedBy: 4)))
        imageView.image = UIImage(named: "splashLogo")
        return imageView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = [.bbdbRed, .bbdbBlue, .bbdbGreen, .bbdbYellow, .bbdbWhite].randomElement()
        view.addSubview(splashImage)
        splashImage.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [weak self] in
            guard let self = self else { return }
            self.startAnimation()
        })
    }
}

// MARK: - Helpers
extension SplashController {
    
    private func startAnimation() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = Double.pi * 4
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        
        let sizeAnimation = CABasicAnimation(keyPath: "transform.scale")
        sizeAnimation.fromValue = CATransform3DIdentity
        sizeAnimation.toValue = CATransform3DScale(CATransform3DIdentity, 15, 15, 1)
        
        let animationsGroup = CAAnimationGroup()
        animationsGroup.animations = [rotationAnimation, opacityAnimation, sizeAnimation]
        animationsGroup.duration = 1.5
        splashImage.layer.add(animationsGroup, forKey: "basic")
        splashImage.layer.opacity = 0
        
        UIView.animate(withDuration: 1.5, animations: { [weak self] in
            guard let self = self else { return }
            self.view.backgroundColor = .bbdbYellow
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                let viewController = TabBarController()
                viewController.modalTransitionStyle = .crossDissolve
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true)
            })
        })
    }
}
