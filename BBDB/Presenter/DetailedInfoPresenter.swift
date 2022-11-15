import UIKit

class DetailedInfoPresenter {
    weak var viewController: DetailedInfoController?
    var link: String?
    
    init(viewController: DetailedInfoController) {
        self.viewController = viewController
    }
    
    @objc func webButtonTapped() {
        let webController = WebController()
        if let webURL = URL(string: link ?? "https://google.com") {
            let request = URLRequest(url: webURL)
            webController.webView.webView.load(request)
        }
        viewController?.present(webController, animated: true)
    }
}
