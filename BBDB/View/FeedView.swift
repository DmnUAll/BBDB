import UIKit

// MARK: - FeedViewDelegate protocol
protocol FeedViewDelegate: AnyObject {
    func webButtonTapped(atPage pageIndex: Int)
}

// MARK: - FeedView
final class FeedView: UIView {
    
    // MARK: - Properties and Initializers
    weak var delegate: FeedViewDelegate?
    
    private let feedActivityIndicator: UIActivityIndicatorView = UICreator.shared.makeActivityIndicator(withColor: .bbdbGreen)
    private let feedScrollView: UIScrollView = UICreator.shared.makeScrollView()
    private let feedPageControl: UIPageControl = UICreator.shared.makePageControll()
    private lazy var linkTextView: UITextView = UICreator.shared.makeTextViewWithLink()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        feedScrollView.delegate = self
        toAutolayout()
        addSubviews()
        setupConstraints()
        showOrHideUI()
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
    
    func fillUI(with feedList: Characters) {
        let width = feedScrollView.bounds.width
        for i in 0...4 {
            let character = feedList[i]
            let scrollViewPage = UICreator.shared.makeStackView(alignment: .center,
                                               distribution: .fillEqually)
            scrollViewPage.frame = CGRect(x: width * CGFloat(i), y: 0, width: width, height: feedScrollView.bounds.height)
            let labelStack = UICreator.shared.makeStackView(distribution: .fillProportionally)
            labelStack.spacing = 0
            labelStack.clipsToBounds = true
            labelStack.toAutolayout()
            labelStack.widthAnchor.constraint(equalToConstant: width - 32).isActive = true
            labelStack.layer.borderColor = UIColor.bbdbBlack.cgColor
            labelStack.layer.borderWidth = 3
            labelStack.layer.cornerRadius = UIScreen.screenSize(dividedBy: 30)
            let imageView = UICreator.shared.makeImageView(withImage: character.imageURL)
            imageView.widthAnchor.constraint(equalToConstant: feedScrollView.bounds.width - 32).isActive = true
            scrollViewPage.addArrangedSubview(imageView)
            scrollViewPage.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(UICreator.shared.makeLabelStack(leadingText: "Name:", trailingText: character.name))
            labelStack.addArrangedSubview(UICreator.shared.makeLabelStack(leadingText: "Gender:", trailingText: character.gender))
            labelStack.addArrangedSubview(UICreator.shared.makeLabelStack(leadingText: "Age:", trailingText: character.age ?? "Unknown"))
            labelStack.addArrangedSubview(UICreator.shared.makeLabelStack(leadingText: "Hair color:", trailingText: character.hairColor ?? "Undefined"))
            labelStack.addArrangedSubview(UICreator.shared.makeLabelStack(leadingText: "Occupation:", trailingText: character.occupation ?? "Unknown"))
            labelStack.addArrangedSubview(UICreator.shared.makeLabelStack(leadingText: "1st appearance:", trailingText: character.firstEpisode ?? "Undefined"))
            labelStack.addArrangedSubview(UICreator.shared.makeLabelStack(leadingText: "Voiced by:", trailingText: character.voicedBy ?? "Undefined"))
            feedScrollView.addSubview(scrollViewPage)
            print(scrollViewPage.frame, " = ", feedScrollView.frame)
            
        }
    }

    func showOrHideUI() {
        feedActivityIndicator.isAnimating ? feedActivityIndicator.stopAnimating() : feedActivityIndicator.startAnimating()
        feedScrollView.isHidden.toggle()
        feedPageControl.isHidden.toggle()
    }
}

// MARK: - UIScrollViewDelegate
extension FeedView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        feedPageControl.currentPage = Int(scrollView.contentOffset.x / CGFloat(feedScrollView.bounds.width))
    }
}
