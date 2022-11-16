import UIKit

final class FavoritesController: UIViewController {
    
    private var presenter: FavoritesPresenter?
    private var alertPresenter: AlertPresenterProtocol?
    lazy var favoritesView: FavoritesView = {
        let favoritesView = FavoritesView()
        return favoritesView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bbdbRed
        view.addSubview(favoritesView)
        setupConstraints()
        presenter = FavoritesPresenter(viewController: self)
        alertPresenter = AlertPresenter(delegate: self)
        favoritesView.favoritesTableView.dataSource = self
        favoritesView.favoritesTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CoreDataManager.loadFavorites()
        favoritesView.favoritesTableView.reloadData()
    }
    
    // MARK: - Helpers
    
    private func setupConstraints() {
        let constraints = [
            favoritesView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoritesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoritesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoritesView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func showAboutFavoritesAlert() {
        let alertModel = AlertModel(title: "About Favorites",
                                    message: "\n Here stores all items that you're added to your favorites list!",
                                    buttonText: "Got it",
                                    completionHandler: nil)
        alertPresenter?.show(alertModel: alertModel)
    }
    
    func showAboutAppAlert() {
        let alertModel = AlertModel(title: "About App",
                                    message: """
                                    
                                    This App was made by me:
                                    https://github.com/DmnUAll
                                    
                                    Based on API:
                                    https://bobs-burgers-api-ui.herokuapp.com
                                    """,
                                    buttonText: "Got it",
                                    completionHandler: nil)
        alertPresenter?.show(alertModel: alertModel)
    }
}

// MARK: - UITAbleViewDataSource

extension FavoritesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.favoritesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCellWithImage", for: indexPath) as! ListViewCellWithImage
        cell.backgroundColor = .clear
        
        let character = CoreDataManager.favoritesArray[indexPath.row] as! Character
        cell.cellImageView.load(url: character.imageURL!)
        cell.cellLabel.text = character.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat().cornerRadiusAutoSize(divider: 8)
    }
}

// MARK: - UITableViewDelegate

extension FavoritesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - AlertPresenterDelegate

extension FavoritesController: AlertPresenterDelegate {
    func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
}
