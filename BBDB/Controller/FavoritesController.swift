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
        favoritesView.favoritesCollectionView.dataSource = self
        favoritesView.favoritesCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CoreDataManager.loadFavorites()
        favoritesView.favoritesCollectionView.reloadData()
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

// MARK: - UICollectionViewDataSource

extension FavoritesController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        header.backgroundColor = .bbdbYellow
        header.configure(withText: "header")
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CoreDataManager.favoritesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as! FavoritesCell
        cell.backgroundColor = .clear
        
        let character = CoreDataManager.favoritesArray[indexPath.row] as! Character
        cell.cellImageView.load(url: character.imageURL!)
        cell.cellLabel.text = character.name
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FavoritesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 50)
    }
}

// MARK: - UICollectionViewDelegate

extension FavoritesController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(123)
    }
}

// MARK: - AlertPresenterDelegate

extension FavoritesController: AlertPresenterDelegate {
    func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
}
