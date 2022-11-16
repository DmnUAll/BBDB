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
    
    let favoritesTableView: UITableView = {
        let tableView = UITableView()
        tableView.toAutolayout()
        tableView.register(ListViewCellWithImage.self, forCellReuseIdentifier: "listCellWithImage")
        tableView.register(ListViewCell.self, forCellReuseIdentifier: "listCell")
        tableView.backgroundColor = .clear
//        tableView.isHidden = true
        return tableView
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
        addSubview(favoritesTableView)
        addSubview(favoritesActivityIndicator)
    }
    
    private func setupConstraints() {
        let constraints = [
            favoritesNavigationBar.topAnchor.constraint(equalTo: topAnchor),
            favoritesNavigationBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            favoritesNavigationBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            favoritesActivityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            favoritesActivityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            favoritesTableView.topAnchor.constraint(equalTo: favoritesNavigationBar.bottomAnchor, constant: 0),
            favoritesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            favoritesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            favoritesTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
