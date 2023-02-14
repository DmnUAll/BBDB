import UIKit

final class ListController: UIViewController {
    
    // MARK: - Properties and Initializers
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    private var presenter: ListPresenter?
    private var alertPresenter: AlertPresenterProtocol?
    lazy var listView: ListView = {
        let listView = ListView()
        return listView
    }()
    
    convenience init(for link: Link) {
        self.init()
        presenter = ListPresenter(viewController: self, link: link)
        alertPresenter = AlertPresenter(delegate: self)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bbdbBlue
        view.addSubview(listView)
        setupConstraints()
        listView.listSearchBar.delegate = self
        listView.listTableView.dataSource = self
        listView.listTableView.delegate = self
        view.addKeyboardHiddingFeature()
    }
}

// MARK: - Helpers
extension ListController {
    
    private func setupConstraints() {
        let constraints = [
            listView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func showNetworkError(message: String) {
        let alertModel = AlertModel(title: "Error",
                                    message: message,
                                    buttonText: "Try again",
                                    completionHandler: { [weak self] _ in
            guard let self = self else { return }
            self.presenter?.loadData()
        })
        alertPresenter?.show(alertModel: alertModel)
    }
    
    func showDuplicatingFavoriteError(message: String) {
        let alertModel = AlertModel(title: "Duplicate Found",
                                    message: message,
                                    buttonText: "Got it!",
                                    completionHandler: nil
        )
        alertPresenter?.show(alertModel: alertModel)
    }
}

// MARK: - UISearchBarDelegate
extension ListController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchRequest = searchBar.text else {
            presenter?.loadData()
            listView.listTableView.reloadData()
            searchBar.resignFirstResponder()
            return
        }
        presenter?.searchData(forRequest: searchRequest.lowercased())
        listView.listTableView.reloadData()
    }
}

// MARK: - UITAbleViewDataSource
extension ListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = presenter?.dataList.count else { return 0 }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = presenter?.configureCell(forIndexPath: indexPath, atTable: tableView) else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.screenSize(dividedBy: 8)
    }
}

// MARK: - UITableViewDelegate
extension ListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let dataFromSelectedRow = presenter?.dataList[indexPath.row] else { return }
        guard let viewController = presenter?.configureViewController(forData: dataFromSelectedRow) else { return }
        show(viewController, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addToFavoriteButton = UIContextualAction(style: .destructive, title: "Add to favorites") { [weak self] _, _, completionHandler in
            guard let self = self else { return }
            self.presenter?.proceedSavingToFavorites(toCategory: self.title, fromRow: indexPath.row)
            completionHandler(true)
        }
        addToFavoriteButton.backgroundColor = .bbdbYellow
        addToFavoriteButton.image = UIImage(systemName: "star")
        let config = UISwipeActionsConfiguration(actions: [addToFavoriteButton])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
}

// MARK: - AlertPresenterDelegate
extension ListController: AlertPresenterDelegate {
    func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
}
