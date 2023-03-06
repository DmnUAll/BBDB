import UIKit

// MARK: - FavoritesController
final class FavoritesController: UIViewController {

    // MARK: - Properties and Initializers
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    private var presenter: FavoritesPresenter?
    private var alertPresenter: AlertPresenterProtocol?
    lazy var favoritesView: FavoritesView = {
        let favoritesView = FavoritesView()
        return favoritesView
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UIImageView.setAsBackground(withImage: K.ImagesNames.greenBackground, to: self)
        view.backgroundColor = .bbdbRed
        view.addSubview(favoritesView)
        setupConstraints()
        presenter = FavoritesPresenter(viewController: self)
        alertPresenter = AlertPresenter(delegate: self)
        favoritesView.favoritesCollectionView.dataSource = self
        favoritesView.favoritesCollectionView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        CoreDataManager.loadAll()
        favoritesView.favoritesCollectionView.reloadData()
    }
}

// MARK: - Helpers
extension FavoritesController {

    private func setupConstraints() {
        let constraints = [
            favoritesView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoritesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoritesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoritesView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - UICollectionViewDataSource
extension FavoritesController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return CoreDataManager.favoritesDictionary.keys.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let header = presenter?.configureHeader(
            forSectionAt: indexPath,
            atCollection: collectionView) else { return HeaderCollectionReusableView() }
        return header
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfItems = presenter?.getNumberOfItems(forSection: section) else { return 0 }
        return numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = presenter?.configureCell(
            forIndexPath: indexPath,
            atCollection: collectionView) else { return UICollectionViewCell() }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavoritesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 50)
    }
}

// MARK: - UICollectionViewDelegate
extension FavoritesController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = presenter?.configureViewController(forSelectedItemAt: indexPath) else { return }
        show(viewController, sender: nil)
    }

    func collectionView(_ collectionView: UICollectionView,
                        contextMenuConfigurationForItemAt indexPath: IndexPath,
                        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let openAction = UIAction(title: "Open", identifier: .none) { [weak self] _ in
                guard let self,
                      let viewController = self.presenter?.configureViewController(
                        forSelectedItemAt: indexPath) else { return }
                self.show(viewController, sender: nil)
            }
            openAction.accessibilityIdentifier = "123"
            let deleteAction = UIAction(title: "Delete", identifier: .none) { [weak self] _ in
                guard let self else { return }
                self.presenter?.deleteItem(at: indexPath)
                collectionView.reloadData()
            }
            return UIMenu(title: "Menu", children: [openAction, deleteAction])
        }
        return configuration
    }
}

// MARK: - AlertPresenterDelegate
extension FavoritesController: AlertPresenterDelegate {
    func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
}

// MARK: - InfoAlertPresenterProtocol
extension FavoritesController: InfoAlertPresenterProtocol {
    func showCurrentControllerInfoAlert() {
        let alertModel = AlertModel(title: "About Favorites",
                                    message: InfoAlertText.aboutFavorites.rawValue,
                                    buttonText: "Got it",
                                    completionHandler: nil)
        alertPresenter?.show(alertModel: alertModel)
    }

    func showAboutAppAlert() {
        let alertModel = AlertModel(title: "About App",
                                    message: InfoAlertText.aboutApp.rawValue,
                                    buttonText: "Got it",
                                    completionHandler: nil)
        alertPresenter?.show(alertModel: alertModel)
    }
}
