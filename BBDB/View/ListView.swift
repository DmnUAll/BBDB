import UIKit

// MARK: - ListView
final class ListView: UIView {
    
    // MARK: - Properties and Initializers
    let listSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.toAutolayout()
        searchBar.barTintColor = .bbdbBlue
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()

    let listTableView: UITableView = {
        let tableView = UITableView()
        tableView.toAutolayout()
        tableView.register(ListViewCellWithImage.self, forCellReuseIdentifier: "listCellWithImage")
        tableView.register(ListViewCell.self, forCellReuseIdentifier: "listCell")
        tableView.backgroundColor = .clear
        tableView.isHidden = true
        tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        return tableView
    }()
    
    private let listActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.toAutolayout()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .bbdbYellow
        activityIndicator.startAnimating()
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
extension ListView {
    
    private func addSubviews() {
        addSubview(listSearchBar)
        addSubview(listTableView)
        addSubview(listActivityIndicator)
    }
    
    private func setupConstraints() {
        let constraints = [
            listSearchBar.topAnchor.constraint(equalTo: topAnchor),
            listSearchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            listSearchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            listActivityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            listActivityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            listTableView.topAnchor.constraint(equalTo: listSearchBar.bottomAnchor),
            listTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            listTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func fillAndReloadTable() {
        listActivityIndicator.isAnimating ? listActivityIndicator.stopAnimating() : listActivityIndicator.startAnimating()
        listTableView.reloadData()
        listTableView.isHidden.toggle()
    }
}
