import UIKit

protocol FavoritesViewDelegate: AnyObject {
    func aboutFavoritesButtonTapped()
    func aboutAppButtonTapped()
}

final class FavoritesView: UIView {
    
    weak var delegate: FavoritesViewDelegate?
    
    private lazy var favoritesNavigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.toAutolayout()
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.backgroundColor = .clear
        navigationBar.tintColor = .bbdbBlack
        let navigationItem = UINavigationItem(title: "Favorites")
        navigationBar.titleTextAttributes = [.font: UIFont(name: "Bob'sBurgers", size: 30)!, .foregroundColor: UIColor.bbdbBlack]
        navigationBar.setTitleVerticalPositionAdjustment(3, for: .default)
        var menuItems: [UIAction] = [
            UIAction(title: "About Favorites", image: UIImage(systemName: "clock.badge.questionmark"), handler: { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.aboutFavoritesButtonTapped()
            }),
            UIAction(title: "About App", image: UIImage(systemName: "questionmark.app"), handler: { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.aboutAppButtonTapped()
            }),
        ]
        var buttonMenu = UIMenu(title: "Info", image: nil, identifier: nil, options: [], children: menuItems)
        let infoButton = UIBarButtonItem(title: "Menu", image: UIImage(systemName: "info.circle"), primaryAction: nil, menu: buttonMenu)
        navigationItem.leftBarButtonItem = infoButton
        navigationBar.setItems([navigationItem], animated: false)
        return navigationBar
    }()
    
    let favoritesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: CGFloat().textAutoSize(divider: 7), height: CGFloat().textAutoSize(divider: 7))
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.toAutolayout()
        collectionView.register(FavoritesCell.self, forCellWithReuseIdentifier: "favoriteCell")
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        collectionView.backgroundColor = .clear
//        tableView.isHidden = true
        return collectionView
    }()
    
    private let favoritesActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.toAutolayout()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .bbdbYellow
//        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        toAutolayout()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(favoritesNavigationBar)
        addSubview(favoritesCollectionView)
        addSubview(favoritesActivityIndicator)
    }
    
    private func setupConstraints() {
        let constraints = [
            favoritesNavigationBar.topAnchor.constraint(equalTo: topAnchor),
            favoritesNavigationBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            favoritesNavigationBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            favoritesActivityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            favoritesActivityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            favoritesCollectionView.topAnchor.constraint(equalTo: favoritesNavigationBar.bottomAnchor, constant: 0),
            favoritesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            favoritesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            favoritesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
