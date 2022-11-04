import UIKit

final class ListView: UIView {
    
    private lazy var listNavigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.toAutolayout()
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.backgroundColor = .clear
        navigationBar.tintColor = .bbdbBlack
        let navigationItem = UINavigationItem(title: "List")
        navigationBar.titleTextAttributes = [.font: UIFont(name: "Bob'sBurgers", size: 30)!, .foregroundColor: UIColor.bbdbBlack]
        navigationBar.setTitleVerticalPositionAdjustment(3, for: .default)
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "x.circle"), style: .plain, target: nil, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem = closeButton
        navigationBar.setItems([navigationItem], animated: false)
        return navigationBar
    }()
    
    private let listTableView: UITableView = {
        let tableView = UITableView()
        tableView.toAutolayout()
        return tableView
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
    
    @objc private func closeButtonTapped() {
        print("Close the list by this button")
    }
    
    private func addSubviews() {
        addSubview(listNavigationBar)
        addSubview(listTableView)
    }
    
    private func setupConstraints() {
        let constraints = [
            listNavigationBar.topAnchor.constraint(equalTo: topAnchor),
            listNavigationBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            listNavigationBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            listTableView.topAnchor.constraint(equalTo: listNavigationBar.bottomAnchor),
            listTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            listTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            listTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
