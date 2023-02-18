import UIKit

// MARK: - DetailedInfoPresenter
final class DetailedInfoPresenter {
    
    // MARK: - Properties and Initialiers
    private weak var viewController: DetailedInfoController?
    var link: String?
    
    init(viewController: DetailedInfoController) {
        self.viewController = viewController
    }
}

// MARK: - Helpers
extension DetailedInfoPresenter {
    
    @objc func webButtonTapped() {
        let webController = WebController()
        if let webURL = URL(string: link ?? "https://google.com") {
            let request = URLRequest(url: webURL)
            webController.webView.webView.load(request)
        }
        viewController?.present(webController, animated: true)
    }
}
