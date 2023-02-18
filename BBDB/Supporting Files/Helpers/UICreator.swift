import UIKit

// MARK: - UICreator
struct UICreator {
    
    static let shared = UICreator()
    
    func makeLabel(text: String? = nil, font: UIFont?, color: UIColor = .bbdbBlack, alignment: NSTextAlignment = .center, andNumberOfLines numberOfLines: Int = 0) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = color
        label.textAlignment = alignment
        label.numberOfLines = numberOfLines
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.text = text
        return label
    }
    
    func makeImageView(withImage url: URL? = nil, backgroundColor: UIColor = .bbdbWhite, borderWidth: CGFloat = 3, dividerForCornerRadius divider: CGFloat = 30) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UIScreen.screenHeight(dividedBy: divider)
        imageView.layer.borderWidth = borderWidth
        imageView.layer.borderColor = UIColor.bbdbBlack.cgColor
        imageView.backgroundColor = backgroundColor
        if let url {
            imageView.load(url: url)
        }
        return imageView
    }
    
    func makeFilledButton(title: String, subtitle: String, backgroundColor: UIColor = .bbdbGray, foregroundColor: UIColor = .bbdbBlack, action: Selector) -> UIButton{
        var filled = UIButton.Configuration.filled()
        filled.buttonSize = .medium
        filled.baseBackgroundColor = backgroundColor
        filled.baseForegroundColor = foregroundColor
        filled.titleAlignment = .center
        filled.title = title
        filled.attributedTitle?.font = UIFont.appFont(.empty, withSize: UIScreen.screenHeight(dividedBy: 25))
        filled.subtitle = subtitle
        filled.attributedSubtitle?.font = UIFont.appFont(.filled, withSize: UIScreen.screenHeight(dividedBy: 40))
        let button = UIButton(configuration: filled, primaryAction: nil)
        button.layer.cornerRadius = UIScreen.screenHeight(dividedBy: 70)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    func makeTable(withCells cells: (type: UITableViewCell.Type, identifier: String)...) -> UITableView {
        let tableView = UITableView()
        tableView.toAutolayout()
        for singleCell in cells {
            tableView.register(singleCell.type, forCellReuseIdentifier: singleCell.identifier)
        }
        tableView.backgroundColor = .clear
        tableView.isHidden = true
        tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        return tableView
    }
    
    func makeActivityIndicator(withColor color: UIColor) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.toAutolayout()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = color
        return activityIndicator
    }
    
    func makeSearchBar() -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.toAutolayout()
        searchBar.barTintColor = .bbdbBlue
        searchBar.backgroundImage = UIImage()
        return searchBar
    }
    
    func makePageControll() -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.toAutolayout()
        pageControl.isEnabled = false
        pageControl.backgroundColor = .clear
        pageControl.currentPageIndicatorTintColor = .bbdbRed
        pageControl.pageIndicatorTintColor = .bbdbRed.withAlphaComponent(0.3)
        pageControl.numberOfPages = 5
        return pageControl
    }
    
    func makeSwitch(withAction action: Selector, andCurrentState state: Bool) -> UISwitch {
        let uiSwitch = UISwitch()
        uiSwitch.toAutolayout()
        uiSwitch.isOn = state
        uiSwitch.addTarget(nil, action: action, for: UIControl.Event.valueChanged)
        uiSwitch.onTintColor = .bbdbGreen
        uiSwitch.thumbTintColor = .bbdbBrown
        return uiSwitch
    }
    
    func makeStackView(axis: NSLayoutConstraint.Axis = .vertical, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill, backgroundColor: UIColor = .clear, addingSpacing spacing: CGFloat = 4) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.backgroundColor = backgroundColor
        stackView.spacing = spacing
        return stackView
    }
    
    func makeLabelStack(leadingText: String, trailingText: String, backgroundColor: UIColor = .bbdbGreen, intersectionColor: UIColor = .bbdbBrown) -> UIStackView {
        let stackView = makeStackView(axis: .horizontal,
                                      alignment: .fill,
                                      distribution: .fillEqually,
                                      backgroundColor: backgroundColor)
        stackView.layer.borderWidth = 2
        stackView.layer.borderColor = intersectionColor.cgColor
        stackView.addArrangedSubview(makeLabel(text: leadingText, font: UIFont.appFont(.empty, withSize: 23), color: .bbdbBlack))
        stackView.addArrangedSubview(makeLabel(text: trailingText, font: UIFont.appFont(.filled, withSize: 23), color: .bbdbBlack, alignment: .left))
        return stackView
    }
    
    func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.toAutolayout()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * 5, height: 0)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }
    
    func makeTextViewWithLink() -> UITextView {
        let attributedString = NSMutableAttributedString(string: "This app was made, using bobsburgersapi.com API")
        attributedString.addAttribute(.link, value: "https://www.bobsburgersapi.com", range: NSRange(location: 25, length: 18))
        let textView = UITextView()
        textView.toAutolayout()
        textView.backgroundColor = .clear
        textView.attributedText = attributedString
        textView.textAlignment = .center
        textView.font = UIFont(name: "Kailasa Bold", size: 12)
        textView.textColor = .bbdbBlack
        textView.isEditable = false
        textView.dataDetectorTypes = .link
        return textView
    }
}
