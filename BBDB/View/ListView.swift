import UIKit

final class ListView: UIView {
    
    let listTableView: UITableView = {
        let tableView = UITableView()
        tableView.toAutolayout()
        tableView.register(ListViewCell.self, forCellReuseIdentifier: "listCell")
        tableView.backgroundColor = .clear
        tableView.isHidden = true
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
    
    private func addSubviews() {
        addSubview(listTableView)
        addSubview(listActivityIndicator)
    }
    
    private func setupConstraints() {
        let constraints = [
            listActivityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            listActivityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            listTableView.topAnchor.constraint(equalTo: topAnchor),
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
