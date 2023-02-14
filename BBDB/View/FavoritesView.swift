import UIKit

// MARK: - FavoritesViewDelegate protocol
protocol FavoritesViewDelegate: AnyObject {
    func aboutFavoritesButtonTapped()
    func aboutAppButtonTapped()
}

// MARK: - FavoritesView
final class FavoritesView: UIView {
    
    // MARK: - Properties and Initializers
    weak var delegate: FavoritesViewDelegate?
    
    let favoritesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.screenSize(dividedBy: 6), height: UIScreen.screenSize(dividedBy: 6))
        layout.sectionInset = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 40
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.toAutolayout()
        collectionView.register(FavoritesCell.self, forCellWithReuseIdentifier: "favoriteCell")
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let favoritesActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.toAutolayout()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .bbdbYellow
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
}

// MARK: - Helpers
extension FavoritesView {
    
    private func addSubviews() {
        addSubview(favoritesCollectionView)
        addSubview(favoritesActivityIndicator)
    }
    
    private func setupConstraints() {
        let constraints = [
            favoritesActivityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            favoritesActivityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            favoritesCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            favoritesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            favoritesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            favoritesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
