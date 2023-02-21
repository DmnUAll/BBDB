import UIKit

// MARK: - FeedViewDelegate protocol
protocol FeedViewDelegate: AnyObject {
    func webButtonTapped(atPage pageIndex: Int)
}

// MARK: - FeedView
final class FeedView: UIView {

    // MARK: - Properties and Initializers
    weak var delegate: FeedViewDelegate?

    let feedActivityIndicator: UIActivityIndicatorView = UICreator.shared.makeActivityIndicator(withColor: .bbdbGreen)
    let feedScrollView: UIScrollView = UICreator.shared.makeScrollView()
    let feedPageControl: UIPageControl = UICreator.shared.makePageControll()
    private lazy var linkTextView: UITextView = UICreator.shared.makeTextViewWithLink()

    override init(frame: CGRect) {
        super.init(frame: frame)
        feedScrollView.accessibilityIdentifier = K.AccessibilityIdentifiers.feedScrollView
        feedPageControl.accessibilityIdentifier = K.AccessibilityIdentifiers.feedPageControl
        feedScrollView.delegate = self
        toAutolayout()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension FeedView {

    @objc func webButtonTapped() {
        delegate?.webButtonTapped(atPage: feedPageControl.currentPage)
    }

    private func addSubviews() {
        addSubview(feedActivityIndicator)
        addSubview(feedScrollView)
        addSubview(feedPageControl)
        addSubview(linkTextView)
    }

    private func setupConstraints() {
        let constraints = [
            linkTextView.heightAnchor.constraint(equalToConstant: 40),
            linkTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            linkTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            linkTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
            feedActivityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            feedActivityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            feedScrollView.topAnchor.constraint(equalTo: topAnchor, constant: 9),
            feedScrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            feedScrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            feedScrollView.bottomAnchor.constraint(equalTo: feedPageControl.topAnchor, constant: 0),
            feedPageControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            feedPageControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            feedPageControl.bottomAnchor.constraint(equalTo: linkTextView.topAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - UIScrollViewDelegate
extension FeedView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        feedPageControl.currentPage = Int(scrollView.contentOffset.x / CGFloat(feedScrollView.bounds.width))
    }
}
