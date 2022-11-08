import UIKit

final class CharactersListController: UIViewController {
    
    private var presenter: CharactersListPresenter?
    private var alertPresenter: AlertPresenterProtocol?
    var characters: Character = []
    lazy var listView: ListView = {
        let listView = ListView()
        return listView
    }()
        
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Characters List"
        view.backgroundColor = .bbdbBlue
        view.addSubview(listView)
        setupConstraints()
        presenter = CharactersListPresenter(viewController: self)
        alertPresenter = AlertPresenter(delegate: self)
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
}

    // MARK: - UITAbleViewDataSource

extension CharactersListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListViewCell
        cell.backgroundColor = .clear
        let character = characters[indexPath.row]
        cell.cellImageView.load(url: character.imageURL)
        cell.cellLabel.text = character.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat().cornerRadiusAutoSize(divider: 8)
    }
}

    // MARK: - UITableViewDelegate

extension CharactersListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        print(character)
        let viewController = DetailedInfoController()
        viewController.detailedInfoView.fillUI(with: character)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - AlertPresenterDelegate

extension CharactersListController: AlertPresenterDelegate {
    func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
}
