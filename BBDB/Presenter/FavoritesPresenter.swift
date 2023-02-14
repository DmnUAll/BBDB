import UIKit
import CoreData

class FavoritesPresenter {
    
    weak var viewController: FavoritesController?
    
    init(viewController: FavoritesController) {
        self.viewController = viewController
        viewController.favoritesView.delegate = self
    }
    
    func configureHeader(forSectionAt indexPath: IndexPath, atCollection collectionView: UICollectionView) -> HeaderCollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
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
    
    func configureCell(forIndexPath indexPath: IndexPath, atCollection collectionView: UICollectionView) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as! FavoritesCell
        cell.backgroundColor = .clear
        switch indexPath.section {
        case 0:
            let character = CoreDataManager.favoritesDictionary[.characters]?[indexPath.row] as! CDCharacter
            cell.cellImageView.load(url: character.imageURL!)
            cell.cellLabel.text = character.name
        case 1:
            let episode = CoreDataManager.favoritesDictionary[.episodes]?[indexPath.row] as! CDEpisode
            cell.cellImageView.load(url: Bundle.main.url(forResource: "noImage", withExtension: "png")!)
            cell.cellLabel.text = episode.name
        case 2:
            let store = CoreDataManager.favoritesDictionary[.stores]?[indexPath.row] as! CDStore
            cell.cellImageView.load(url: store.imageURL!)
            cell.cellLabel.text = store.name
        case 3:
            let truck = CoreDataManager.favoritesDictionary[.trucks]?[indexPath.row] as! CDTruck
            cell.cellImageView.load(url: truck.imageURL!)
            cell.cellLabel.text = truck.name
        case 4:
            let credits = CoreDataManager.favoritesDictionary[.credits]?[indexPath.row] as! CDCredits
            cell.cellImageView.load(url: credits.imageURL!)
            cell.cellLabel.text = "S\(credits.season)E\(credits.episode)"
        case 5:
            let burger = CoreDataManager.favoritesDictionary[.burgers]?[indexPath.row] as! CDBurger
            cell.cellImageView.load(url: Bundle.main.url(forResource: "noImage", withExtension: "png")!)
            cell.cellLabel.text = burger.name
        default:
            return cell
        }
        return cell
    }
    
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
        
        guard let dataFromSelectedRow = CoreDataManager.favoritesDictionary[dictionaryKey]?[indexPath.row] else { return UIViewController() }
        let viewController = DetailedInfoController()
        viewController.view.backgroundColor = .bbdbGreen
        if let dataFromSelectedRow = dataFromSelectedRow as? CDCharacter {
            viewController.title = "Character's Info"
            viewController.detailedInfoView.fillUI(with: dataFromSelectedRow)
            if let wikiURL = dataFromSelectedRow.wikiURL {
                viewController.addWebButton(withLink: wikiURL)
            }
        }
        if let dataFromSelectedRow = dataFromSelectedRow as? CDEpisode {
            viewController.title = "Episode Info"
            viewController.detailedInfoView.fillUI(with: dataFromSelectedRow)
            if let wikiURL = dataFromSelectedRow.wikiURL {
                viewController.addWebButton(withLink: wikiURL)
            }
        }
        if let dataFromSelectedRow = dataFromSelectedRow as? CDStore {
            viewController.title = "Store Info"
            viewController.detailedInfoView.fillUI(with: dataFromSelectedRow)
        }
        if let dataFromSelectedRow = dataFromSelectedRow as? CDTruck {
            viewController.title = "Truck Info"
            viewController.detailedInfoView.fillUI(with: dataFromSelectedRow)
        }
        if let dataFromSelectedRow = dataFromSelectedRow as? CDCredits {
            viewController.title = "End Credits Info"
            viewController.detailedInfoView.fillUI(with: dataFromSelectedRow)
        }
        if let dataFromSelectedRow = dataFromSelectedRow as? CDBurger {
            viewController.title = "Burger Info"
            viewController.detailedInfoView.fillUI(with: dataFromSelectedRow)
        }
        return viewController
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
