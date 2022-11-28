import UIKit

protocol FavoritesViewDelegate: AnyObject {
    func aboutFavoritesButtonTapped()
    func aboutAppButtonTapped()
}

final class FavoritesView: UIView {
    
    weak var delegate: FavoritesViewDelegate?
    
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
