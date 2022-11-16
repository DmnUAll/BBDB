import UIKit
import WebKit

final class WebView: UIView {
    
    private let webNavigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.toAutolayout()
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.backgroundColor = .clear
        navigationBar.tintColor = .bbdbBlack
        let navigationItem = UINavigationItem(title: "Character's Wiki")
        navigationBar.titleTextAttributes = [.font: UIFont(name: "Bob'sBurgers", size: 30)!, .foregroundColor: UIColor.bbdbBlack]
        navigationBar.setTitleVerticalPositionAdjustment(3, for: .default)
        let refreshButton = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: nil, action: #selector(refreshButtonTapped))
        let backwardButton = UIBarButtonItem(image: UIImage(systemName: "chevron.right"), style: .plain, target: nil, action: #selector(forwardButtonTapped))
        let forwardButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: nil, action: #selector(backwardButtonTapped))
        navigationItem.rightBarButtonItem = refreshButton
        navigationItem.leftBarButtonItems = [forwardButton, backwardButton]
        navigationBar.setItems([navigationItem], animated: false)
        return navigationBar
    }()
    
    let webView: WKWebView = {
        let webView = WKWebView()
        webView.toAutolayout()
        return webView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        toAutolayout()
        addSubviews()
        setupConstraints()
        webView.navigationDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func refreshButtonTapped() {
        webView.reload()
    }
    
    @objc private func forwardButtonTapped() {
        webView.goForward()
    }
    
    @objc private func backwardButtonTapped() {
        webView.goBack()
    }
    
    private func addSubviews() {
        addSubview(webNavigationBar)
        addSubview(webView)
    }
    
    func updateButtons() {
        guard let webControlButtons = webNavigationBar.items?[0].leftBarButtonItems else { return }
        webControlButtons.first?.isEnabled = webView.canGoBack
        webControlButtons.last?.isEnabled = webView.canGoForward
    }
    
    private func setupConstraints() {
        let constraints = [
            webNavigationBar.topAnchor.constraint(equalTo: topAnchor),
            webNavigationBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            webNavigationBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            webView.topAnchor.constraint(equalTo: webNavigationBar.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
extension WebView: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if webView.isLoading {
            updateButtons()
        }
        decisionHandler(.allow)
    }
}
