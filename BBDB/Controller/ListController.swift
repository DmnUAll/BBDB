import UIKit

final class ListController: UIViewController {

    lazy var listView: ListView = {
        let listView = ListView()
        return listView
    }()
        
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bbdbBlue
        view.addSubview(listView)
        setupConstraints()
        listView.listTableView.dataSource = self
        listView.listTableView.delegate = self
    }
    
    // MARK: - Helpers

    private func setupConstraints() {
        let constraints = [
            listView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

    // MARK: - UITAbleViewDataSource

extension ListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListViewCell
        cell.backgroundColor = .clear
        cell.cellImageView.image = UIImage(named: "noImage")
        cell.cellLabel.text = "123"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat().cornerRadiusAutoSize(divider: 12)
    }
}

    // MARK: - UITableViewDelegate

extension ListController: UITableViewDelegate {
    
}
