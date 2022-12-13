import UIKit
import CoreData


class ListPresenter {
    
    private let listLoader: NetworkDataLoading
    weak var viewController: ListController?
    private let link: Link
    var dataList: [Any] = []
    
    init(viewController: ListController, link: Link) {
        CoreDataManager.loadAll()
        self.viewController = viewController
        listLoader = NetworkDataLoader(link: link)
        self.link = link
        self.setTitleToVC(basedOnLink: self.link)
        loadData()
    }
    
    func loadData() {
        switch link {
        case . charactersList:
            listLoader.loadList { (result: Result<Characters, Error>) in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    switch result {
                    case .success(let loadedDataList):
                        self.dataList = loadedDataList
                        self.viewController?.listView.fillAndReloadTable()
                    case .failure(let error):
                        self.viewController?.showNetworkError(message: error.localizedDescription)
                    }
                }
            }
        case .episodesList:
            listLoader.loadList { (result: Result<Episodes, Error>) in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    switch result {
                    case .success(let loadedDataList):
                        self.dataList = loadedDataList
                        self.viewController?.listView.fillAndReloadTable()
                    case .failure(let error):
                        self.viewController?.showNetworkError(message: error.localizedDescription)
                    }
                }
            }
        case .nextDoorStoresList:
            listLoader.loadList { (result: Result<Stores, Error>) in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    switch result {
                    case .success(let loadedDataList):
                        self.dataList = loadedDataList
                        self.viewController?.listView.fillAndReloadTable()
                    case .failure(let error):
                        self.viewController?.showNetworkError(message: error.localizedDescription)
                    }
                }
            }
        case .pestControllTrucksList:
            listLoader.loadList { (result: Result<PestControlTrucks, Error>) in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    switch result {
                    case .success(let loadedDataList):
                        self.dataList = loadedDataList
                        self.viewController?.listView.fillAndReloadTable()
                    case .failure(let error):
                        self.viewController?.showNetworkError(message: error.localizedDescription)
                    }
                }
            }
        case .endCreditsList:
            listLoader.loadList { (result: Result<EndCredits, Error>) in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    switch result {
                    case .success(let loadedDataList):
                        self.dataList = loadedDataList
                        self.viewController?.listView.fillAndReloadTable()
                    case .failure(let error):
                        self.viewController?.showNetworkError(message: error.localizedDescription)
                    }
                }
            }
        case .burgersOfTheDayList:
            listLoader.loadList { (result: Result<BurgersOfTheDay, Error>) in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    switch result {
                    case .success(let loadedDataList):
                        self.dataList = loadedDataList
                        self.viewController?.listView.fillAndReloadTable()
                    case .failure(let error):
                        self.viewController?.showNetworkError(message: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func checkForDuplicate(of data: NSManagedObject, at dictionaryKey: CoreDataManager.Categories) {
        var foundDuplicate = false
        
        switch type(of: data) {
        case is CDCharacter.Type:
            let favoritesCategoryList = CoreDataManager.favoritesDictionary[dictionaryKey]! as! [CDCharacter]
            let castedData = data as! CDCharacter
            foundDuplicate = favoritesCategoryList.contains(where: {$0.id == castedData.id})
        case is CDEpisode.Type:
            let favoritesCategoryList = CoreDataManager.favoritesDictionary[dictionaryKey]! as! [CDEpisode]
            let castedData = data as! CDEpisode
            foundDuplicate = favoritesCategoryList.contains(where: {$0.id == castedData.id})
        case is CDStore.Type:
            let favoritesCategoryList = CoreDataManager.favoritesDictionary[dictionaryKey]! as! [CDStore]
            let castedData = data as! CDStore
            foundDuplicate = favoritesCategoryList.contains(where: {$0.id == castedData.id})
        case is CDTruck.Type:
            let favoritesCategoryList = CoreDataManager.favoritesDictionary[dictionaryKey]! as! [CDTruck]
            let castedData = data as! CDTruck
            foundDuplicate = favoritesCategoryList.contains(where: {$0.id == castedData.id})
        case is CDCredits.Type:
            let favoritesCategoryList = CoreDataManager.favoritesDictionary[dictionaryKey]! as! [CDCredits]
            let castedData = data as! CDCredits
            foundDuplicate = favoritesCategoryList.contains(where: {$0.id == castedData.id})
        case is CDBurger.Type:
            let favoritesCategoryList = CoreDataManager.favoritesDictionary[dictionaryKey]! as! [CDBurger]
            let castedData = data as! CDBurger
            foundDuplicate = favoritesCategoryList.contains(where: {$0.id == castedData.id})
        default:
            return
        }
        if foundDuplicate {
            CoreDataManager.context.delete(data)
            viewController?.showDuplicatingFavoriteError(message: "That item is already in your Favorites!")
        } else {
            CoreDataManager.favoritesDictionary[dictionaryKey]?.append(data)
            CoreDataManager.saveFavorites()
        }
    }
    
    private func setTitleToVC(basedOnLink link: Link) {
        switch link {
        case .charactersList:
            viewController?.title = "Characters List"
        case .episodesList:
            viewController?.title = "Episodes List"
        case .nextDoorStoresList:
            viewController?.title = "Stores List"
        case .pestControllTrucksList:
            viewController?.title = "Trucks List"
        case .endCreditsList:
            viewController?.title = "End Credits List"
        case .burgersOfTheDayList:
            viewController?.title = "Burgers List"
        }
    }
    
    func configureCell(forIndexPath indexPath: IndexPath, atTable tableView: UITableView) -> UITableViewCell {
        switch dataList[0] {
        case is CharacterModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: "listCellWithImage", for: indexPath) as! ListViewCellWithImage
            cell.backgroundColor = .clear
            guard let character = dataList[indexPath.row] as? CharacterModel else { return cell }
            cell.cellImageView.load(url: character.imageURL)
            cell.cellLabel.text = character.name
            return cell
        case is EpisodeModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListViewCell
            cell.backgroundColor = .clear
            guard let episode = dataList[indexPath.row] as? EpisodeModel else { return cell }
            cell.cellMainLabel.text = episode.name
            cell.cellAdditionLabel.text = "Season: \(episode.season) / Episode: \(episode.episode)"
            return cell
        case is StoreModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: "listCellWithImage", for: indexPath) as! ListViewCellWithImage
            cell.backgroundColor = .clear
            guard let store = dataList[indexPath.row] as? StoreModel else { return cell }
            cell.cellImageView.load(url: store.imageURL)
            cell.cellLabel.text = store.name
            return cell
        case is PestControlTruckModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: "listCellWithImage", for: indexPath) as! ListViewCellWithImage
            cell.backgroundColor = .clear
            guard let truck = dataList[indexPath.row] as? PestControlTruckModel else { return cell }
            cell.cellImageView.load(url: truck.imageURL)
            cell.cellLabel.text = truck.name
            return cell
        case is EndCreditsModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: "listCellWithImage", for: indexPath) as! ListViewCellWithImage
            cell.backgroundColor = .clear
            guard let credits = dataList[indexPath.row] as? EndCreditsModel else { return cell }
            cell.cellImageView.load(url: credits.imageURL)
            cell.cellLabel.text = "Season: \(credits.season) Episode: \(credits.episode)"
            return cell
        case is BurgerOfTheDayModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListViewCell
            cell.backgroundColor = .clear
            guard let burger = dataList[indexPath.row] as? BurgerOfTheDayModel else { return cell }
            cell.cellMainLabel.text = burger.name
            cell.cellAdditionLabel.text = "Seaseon: \(burger.season) Episode: \(burger.episode)"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListViewCell
            return cell
        }
    }
    
    func configureViewController(forData data: Any) -> DetailedInfoController {
        let viewController = DetailedInfoController()
        if let data = data as? CharacterModel {
            viewController.title = "Character's Info"
            viewController.detailedInfoView.fillUI(with: data)
            viewController.addWebButton(withLink: data.wikiURL)
        }
        if let data = data as? EpisodeModel {
            viewController.title = "Episode Info"
            viewController.detailedInfoView.fillUI(with: data)
            viewController.addWebButton(withLink: data.wikiURL)
        }
        if let data = data as? StoreModel {
            viewController.title = "Store Info"
            viewController.detailedInfoView.fillUI(with: data)
        }
        if let data = data as? PestControlTruckModel {
            viewController.title = "Truck Info"
            viewController.detailedInfoView.fillUI(with: data)
        }
        if let data = data as? EndCreditsModel {
            viewController.title = "End Credits Info"
            viewController.detailedInfoView.fillUI(with: data)
        }
        if let data = data as? BurgerOfTheDayModel {
            viewController.title = "Burger Info"
            viewController.detailedInfoView.fillUI(with: data)
        }
        return viewController
    }
    
    func proceedSavingToFavorites(toCategory category: String?, fromRow index: Int) {
        switch category {
        case "Characters List":
            let character = dataList[index] as! CharacterModel
            let newFavorite = CDCharacter(context: CoreDataManager.context)
            newFavorite.id = Int64(character.id)
            newFavorite.name = character.name
            newFavorite.gender = character.gender
            newFavorite.age = character.age ?? "Unknown"
            newFavorite.hairColor = character.hairColor ?? "Undefined"
            newFavorite.occupation = character.occupation ?? "Unknown"
            newFavorite.firstEpisode = character.firstEpisode ?? "Undefined"
            newFavorite.voicedBy = character.voicedBy ?? "Undefined"
            newFavorite.imageURL = character.imageURL
            newFavorite.wikiURL = character.wikiURL
            checkForDuplicate(of: newFavorite, at: .characters)
        case "Episodes List":
            let episode = dataList[index] as! EpisodeModel
            let newFavorite = CDEpisode(context: CoreDataManager.context)
            newFavorite.id = Int64(episode.id)
            newFavorite.name = episode.name
            newFavorite.season = Int64(episode.season)
            newFavorite.episode = Int64(episode.episode)
            newFavorite.airDate = episode.airDate
            newFavorite.totalViewers = episode.totalViewers
            newFavorite.wikiURL = episode.wikiURL
            checkForDuplicate(of: newFavorite, at: .episodes)
        case "Stores List":
            let store = dataList[index] as! StoreModel
            let newFavorite = CDStore(context: CoreDataManager.context)
            newFavorite.id = Int64(store.id)
            newFavorite.name = store.name
            newFavorite.season = Int64(store.season)
            newFavorite.episode = Int64(store.episode)
            newFavorite.imageURL = store.imageURL
            checkForDuplicate(of: newFavorite, at: .stores)
        case "Trucks List":
            let truck = dataList[index] as! PestControlTruckModel
            let newFavorite = CDTruck(context: CoreDataManager.context)
            newFavorite.id = Int64(truck.id)
            newFavorite.name = truck.name
            newFavorite.season = Int64(truck.season)
            newFavorite.imageURL = truck.imageURL
            checkForDuplicate(of: newFavorite, at: .trucks)
        case "End Credits List":
            let credits = dataList[index] as! EndCreditsModel
            let newFavorite = CDCredits(context: CoreDataManager.context)
            newFavorite.id = Int64(credits.id)
            newFavorite.episode = Int64(credits.episode)
            newFavorite.season = Int64(credits.season)
            newFavorite.imageURL = credits.imageURL
            checkForDuplicate(of: newFavorite, at: .credits)
        case "Burgers List":
            let burger = dataList[index] as! BurgerOfTheDayModel
            let newFavorite = CDBurger(context: CoreDataManager.context)
            newFavorite.id = Int64(burger.id)
            newFavorite.episode = Int64(burger.episode)
            newFavorite.season = Int64(burger.season)
            newFavorite.name = burger.name
            newFavorite.price = burger.price
            checkForDuplicate(of: newFavorite, at: .burgers)
        default:
            return
        }
    }
}
