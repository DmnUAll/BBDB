import UIKit

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
        view.backgroundColor = [ .bbdbRed, .bbdbBlue, .bbdbGreen, .bbdbYellow].randomElement()
        view.addSubview(splashImage)
        splashImage.center = view.center
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [weak self] in
            guard let self = self else { return }
            self.animate()
        })
    }
}

// MARK: - Helpers
extension SplashController {

    private func animate() {
        UIView.animate(withDuration: 1.0) { [weak self] in
            guard let self = self else { return }
            let size = self.view.frame.size.width * 5
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            
            self.splashImage.frame = CGRect(
                x: -(diffX / 2),
                y: diffY / 2,
                width: size,
                height: size
            )
            for _ in 1...4 {
                self.splashImage.transform = self.splashImage.transform.rotated(by: .pi * -1.5)
            }
        }
        
        UIView.animate(withDuration: 1.5, animations: { [weak self] in
            guard let self = self else { return }
            self.splashImage.alpha = 0
            self.view.backgroundColor = .bbdbYellow
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                let viewController = TabBarController()
                viewController.modalTransitionStyle = .crossDissolve
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true)
            })
        })
    }
}
