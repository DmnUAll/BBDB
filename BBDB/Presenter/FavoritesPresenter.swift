import UIKit
import CoreData

// MARK: - FavoritesPresenter
final class FavoritesPresenter {

    // MARK: - Properties and Initializers
    private weak var viewController: FavoritesController?

    init(viewController: FavoritesController) {
        self.viewController = viewController
        viewController.favoritesView.delegate = self
    }
}

// MARK: - Helpers
extension FavoritesPresenter {

    func configureHeader(forSectionAt indexPath: IndexPath,
                         atCollection collectionView: UICollectionView
    ) -> HeaderCollectionReusableView? {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: K.Identifiers.header,
            for: indexPath) as? HeaderCollectionReusableView else { return nil }
        header.backgroundColor = .clear
        header.configure(withText: "\(CoreDataManager.Categories.allCases[indexPath.section].rawValue)")
        return header
    }

    func getNumberOfItems(forSection section: Int) -> Int {
        switch section {
        case 0:
            return CoreDataManager.favoritesDictionary[.characters]?.count ?? 0
        case 1:
            return CoreDataManager.favoritesDictionary[.episodes]?.count ?? 0
        case 2:
            return CoreDataManager.favoritesDictionary[.stores]?.count ?? 0
        case 3:
            return CoreDataManager.favoritesDictionary[.trucks]?.count ?? 0
        case 4:
            return CoreDataManager.favoritesDictionary[.credits]?.count ?? 0
        case 5:
            return CoreDataManager.favoritesDictionary[.burgers]?.count ?? 0
        default:
            return 0
        }
    }

    // swiftlint:disable cyclomatic_complexity
    func configureCell(forIndexPath indexPath: IndexPath,
                       atCollection collectionView: UICollectionView
    ) -> UICollectionViewCell? {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.Identifiers.favoriteCell,
                                                            for: indexPath) as? FavoritesCell else { return nil }
        cell.backgroundColor = .clear
        let favorites = CoreDataManager.favoritesDictionary
        switch indexPath.section {
        case 0:
            guard let character = favorites[.characters]?[indexPath.row] as? CDCharacter else { return nil }
            cell.cellImageView.load(url: character.imageURL!)
            cell.cellLabel.text = character.name
        case 1:
            guard let episode = favorites[.episodes]?[indexPath.row] as? CDEpisode else { return nil }
            cell.cellImageView.load(url: Bundle.main.url(forResource: K.ImagesNames.noImage, withExtension: "png")!)
            cell.cellLabel.text = episode.name
        case 2:
            guard let store = favorites[.stores]?[indexPath.row] as? CDStore else { return nil }
            cell.cellImageView.load(url: store.imageURL!)
            cell.cellLabel.text = store.name
        case 3:
            guard let truck = favorites[.trucks]?[indexPath.row] as? CDTruck else { return nil }
            cell.cellImageView.load(url: truck.imageURL!)
            cell.cellLabel.text = truck.name
        case 4:
            guard let credits = favorites[.credits]?[indexPath.row] as? CDCredits else { return nil }
            cell.cellImageView.load(url: credits.imageURL!)
            cell.cellLabel.text = "S\(credits.season)E\(credits.episode)"
        case 5:
            guard let burger = favorites[.burgers]?[indexPath.row] as? CDBurger else { return nil }
            cell.cellImageView.load(url: Bundle.main.url(forResource: K.ImagesNames.noImage, withExtension: "png")!)
            cell.cellLabel.text = burger.name
        default:
            return cell
        }
        return cell
    }

    // swiftlint:disable:next function_body_length
    func configureViewController(forSelectedItemAt indexPath: IndexPath) -> UIViewController {
        let dictionaryKey: CoreDataManager.Categories
        switch indexPath.section {
        case 0:
            dictionaryKey = .characters
        case 1:
            dictionaryKey = .episodes
        case 2:
            dictionaryKey = .stores
        case 3:
            dictionaryKey = .trucks
        case 4:
            dictionaryKey = .credits
        case 5:
            dictionaryKey = .burgers
        default:
            return UIViewController()
        }

        guard let dataFromSelectedRow = CoreDataManager.favoritesDictionary[dictionaryKey]?[indexPath.row] else {
            return UIViewController()
        }
        let viewController = DetailedInfoController()
        viewController.view.backgroundColor = .bbdbGreen
        if let dataFromSelectedRow = dataFromSelectedRow as? CDCharacter {
            viewController.title = String.charactersInfo
            viewController.fillUI(with: dataFromSelectedRow)
            if let wikiURL = dataFromSelectedRow.wikiURL {
                viewController.addWebButton(withLink: wikiURL)
            }
        }
        if let dataFromSelectedRow = dataFromSelectedRow as? CDEpisode {
            viewController.title = String.episodesInfo
            viewController.fillUI(with: dataFromSelectedRow)
            if let wikiURL = dataFromSelectedRow.wikiURL {
                viewController.addWebButton(withLink: wikiURL)
            }
        }
        if let dataFromSelectedRow = dataFromSelectedRow as? CDStore {
            viewController.title = String.storeInfo
            viewController.fillUI(with: dataFromSelectedRow)
        }
        if let dataFromSelectedRow = dataFromSelectedRow as? CDTruck {
            viewController.title = String.truckInfo
            viewController.fillUI(with: dataFromSelectedRow)
        }
        if let dataFromSelectedRow = dataFromSelectedRow as? CDCredits {
            viewController.title = String.creditsInfo
            viewController.fillUI(with: dataFromSelectedRow)
        }
        if let dataFromSelectedRow = dataFromSelectedRow as? CDBurger {
            viewController.title = String.burgersInfo
            viewController.fillUI(with: dataFromSelectedRow)
        }
        return viewController
    }

    func deleteItem(at indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            CoreDataManager.deleteItem(withKey: CoreDataManager.Categories.characters, at: indexPath.row)
        case 1:
            CoreDataManager.deleteItem(withKey: CoreDataManager.Categories.episodes, at: indexPath.row)
        case 2:
            CoreDataManager.deleteItem(withKey: CoreDataManager.Categories.stores, at: indexPath.row)
        case 3:
            CoreDataManager.deleteItem(withKey: CoreDataManager.Categories.trucks, at: indexPath.row)
        case 4:
            CoreDataManager.deleteItem(withKey: CoreDataManager.Categories.credits, at: indexPath.row)
        case 5:
            CoreDataManager.deleteItem(withKey: CoreDataManager.Categories.burgers, at: indexPath.row)
        default:
            return
        }
    }
}

// MARK: - FeedViewDelegate
extension FavoritesPresenter: FavoritesViewDelegate {

    func aboutFavoritesButtonTapped() {
        viewController?.showCurrentControllerInfoAlert()
    }

    func aboutAppButtonTapped() {
        viewController?.showAboutAppAlert()
        viewController?.navigationController?.pushViewController(WhoAmIResultController(), animated: true)
    }
}

// MARK: - String fileprivate extension
fileprivate extension String {
    static let charactersInfo = "Character's Info"
    static let episodesInfo = "Episode Info"
    static let storeInfo = "Store Info"
    static let truckInfo = "Truck Info"
    static let creditsInfo = "End Credits Info"
    static let burgersInfo = "Burgers Info"
}
