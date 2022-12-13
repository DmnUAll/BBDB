import UIKit

protocol FeedViewDelegate: AnyObject {
    func webButtonTapped(atPage pageIndex: Int)
}

final class FeedView: UIView {
    
    weak var delegate: FeedViewDelegate?
    
    private let feedActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.toAutolayout()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .bbdbBlue
        return activityIndicator
    }()
    
    private let feedScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutolayout()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * 5, height: 0)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let feedPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.toAutolayout()
        pageControl.isEnabled = false
        pageControl.backgroundColor = .clear
        pageControl.currentPageIndicatorTintColor = .bbdbBlack
        pageControl.numberOfPages = 5
        return pageControl
    }()
    
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
    
    @objc func webButtonTapped() {
        delegate?.webButtonTapped(atPage: feedPageControl.currentPage)
    }
    
    private func addSubviews() {
        addSubview(feedActivityIndicator)
        addSubview(feedScrollView)
        addSubview(feedPageControl)
    }
    
    private func setupConstraints() {
        let constraints = [
            feedActivityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            feedActivityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            feedScrollView.topAnchor.constraint(equalTo: topAnchor),
            feedScrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            feedScrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            feedScrollView.bottomAnchor.constraint(equalTo: feedPageControl.topAnchor, constant: 0),
            feedPageControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            feedPageControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            feedPageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func fillUI(with feedList: Characters) {
        let width = feedScrollView.bounds.width
        for i in 0...4 {
            let character = feedList[i]
            let scrollViewPage = makeStackView(axis: .vertical,
                                               alignment: .center,
                                               distribution: .fillEqually,
                                               backgroundColor: .clear)
            scrollViewPage.frame = CGRect(x: width * CGFloat(i), y: 0, width: width, height: feedScrollView.bounds.height)
            let labelStack = makeStackView(axis: .vertical,
                                           alignment: .fill,
                                           distribution: .fillProportionally,
                                           backgroundColor: .bbdbSkin)
            labelStack.spacing = 0
            labelStack.clipsToBounds = true
            labelStack.toAutolayout()
            labelStack.widthAnchor.constraint(equalToConstant: width - 32).isActive = true
            labelStack.layer.borderColor = UIColor.bbdbBlack.cgColor
            labelStack.layer.borderWidth = 3
            labelStack.layer.cornerRadius = UIScreen.screenSize(dividedBy: 30)
            scrollViewPage.addArrangedSubview(makeImageView(withImage: character.imageURL))
            scrollViewPage.addArrangedSubview(labelStack)
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Name:", trailingText: character.name))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Gender:", trailingText: character.gender))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Age:", trailingText: character.age ?? "Unknown"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Hair color:", trailingText: character.hairColor ?? "Undefined"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Occupation:", trailingText: character.occupation ?? "Unknown"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "1st appearance:", trailingText: character.firstEpisode ?? "Undefined"))
            labelStack.addArrangedSubview(makeLabelStack(leadingText: "Voiced by:", trailingText: character.voicedBy ?? "Undefined"))
            feedScrollView.addSubview(scrollViewPage)
            print(scrollViewPage.frame, " = ", feedScrollView.frame)

        }
        showOrHideUI()
    }
    private func showOrHideUI() {
        feedActivityIndicator.isAnimating ? feedActivityIndicator.stopAnimating() : feedActivityIndicator.startAnimating()
        feedScrollView.isHidden.toggle()
        feedPageControl.isHidden.toggle()
    }
}

extension FeedView {
    
    private func makeStackView(axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment, distribution: UIStackView.Distribution, backgroundColor: UIColor) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.backgroundColor = backgroundColor
        stackView.spacing = 4
        return stackView
    }
    
    private func makeImageView(withImage url: URL) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UIScreen.screenSize(dividedBy: 30)
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.bbdbBlack.cgColor
        imageView.backgroundColor = .bbdbWhite
        imageView.widthAnchor.constraint(equalToConstant: feedScrollView.bounds.width - 32).isActive = true
        imageView.load(url: url)
        
        return imageView
    }
    
    private func makeLabel(text: String, font: String, color: UIColor, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: font, size: 23)
        label.textColor = color
        label.textAlignment = alignment
        label.numberOfLines = 0
        label.text = text
        return label
    }
    
    private func makeLabelStack(leadingText: String, trailingText: String) -> UIStackView {
        let stackView = makeStackView(axis: .horizontal,
                                      alignment: .center,
                                      distribution: .fillProportionally,
                                      backgroundColor: .bbdbBlue)
        stackView.layer.borderWidth = 2
        stackView.layer.borderColor = UIColor.bbdbGray.cgColor
        stackView.addArrangedSubview(makeLabel(text: leadingText, font: "Bob'sBurgers2", color: .bbdbBlack, alignment: .center))
        stackView.addArrangedSubview(makeLabel(text: trailingText, font: "Bob'sBurgers", color: .bbdbBlack, alignment: .left))
        return stackView
    }
}

extension FeedView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        feedPageControl.currentPage = Int(scrollView.contentOffset.x / CGFloat(feedScrollView.bounds.width))
    }
}
