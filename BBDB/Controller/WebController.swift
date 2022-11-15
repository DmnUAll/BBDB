import UIKit

final class WebController: UIViewController {
        
    lazy var webView: WebView = {
        let webView = WebView()
        return webView
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bbdbYellow
        view.addSubview(webView)
        setupConstraints()
    }
    
    // MARK: - Helpers

    private func setupConstraints() {
        let constraints = [
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
