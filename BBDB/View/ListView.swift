import UIKit

final class ListView: UIView {
    
    let listTableView: UITableView = {
        let tableView = UITableView()
        tableView.toAutolayout()
        tableView.register(ListViewCell.self, forCellReuseIdentifier: "listCell")
        tableView.backgroundColor = .clear
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
        addSubview(listTableView)
    }
    
    private func setupConstraints() {
        let constraints = [
            listTableView.topAnchor.constraint(equalTo: topAnchor),
            listTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            listTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
