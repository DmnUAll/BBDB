import UIKit
import CoreData

// MARK: - ListPresenter
final class ListPresenter {

    // MARK: - Properties and Initializers
    private let listLoader: NetworkDataLoading
    private weak var viewController: ListController?
    private let link: Link
    var dataList: [Any] = []
    private var fullList: [Any] = []

    init(viewController: ListController, link: Link) {
        CoreDataManager.loadAll()
        self.viewController = viewController
        listLoader = NetworkDataLoader(link: link)
        self.link = link
        self.setTitleToVC(basedOnLink: self.link)
        loadData()
    }
}

// MARK: - Helpers
extension ListPresenter {

    func loadData() {
        func proceedRequest<T: Codable>(forResult result: Result<T, Error>) {
            DispatchQueue.main.async {
                switch result {
                case .success(let loadedDataList):
                    guard let castedDataList = loadedDataList as? [Any] else { return }
                    self.dataList = castedDataList
                    self.fullList = castedDataList
                    self.viewController?.listView.fillAndReloadTable()
                case .failure(let error):
                    self.viewController?.showNetworkError(message: error.localizedDescription)
                }
            }
        }
        switch link {
        case . charactersList:
            listLoader.loadList { (result: Result<Characters, Error>) in
                proceedRequest(forResult: result)
            }
        case .episodesList:
            listLoader.loadList { (result: Result<Episodes, Error>) in
                proceedRequest(forResult: result)
            }
        case .nextDoorStoresList:
            listLoader.loadList { (result: Result<Stores, Error>) in
                proceedRequest(forResult: result)
            }
        case .pestControllTrucksList:
            listLoader.loadList { (result: Result<PestControlTrucks, Error>) in
                proceedRequest(forResult: result)
            }
        case .endCreditsList:
            listLoader.loadList { (result: Result<EndCredits, Error>) in
                proceedRequest(forResult: result)
            }
        case .burgersOfTheDayList:
            listLoader.loadList { (result: Result<BurgersOfTheDay, Error>) in
                proceedRequest(forResult: result)
            }
        }
    }

    // swiftlint:disable:next cyclomatic_complexity
    private func checkForDuplicate(of data: NSManagedObject, at dictionaryKey: CoreDataManager.Categories) {
        var foundDuplicate = false
        switch type(of: data) {
        case is CDCharacter.Type:
            guard let favoritesCategoryList = CoreDataManager.favoritesDictionary[dictionaryKey]! as? [CDCharacter],
                  let castedData = data as? CDCharacter else { return }
            foundDuplicate = favoritesCategoryList.contains(where: {$0.id == castedData.id})
        case is CDEpisode.Type:
            guard let favoritesCategoryList = CoreDataManager.favoritesDictionary[dictionaryKey]! as? [CDEpisode],
                  let castedData = data as? CDEpisode else { return }
            foundDuplicate = favoritesCategoryList.contains(where: {$0.id == castedData.id})
        case is CDStore.Type:
            guard let favoritesCategoryList = CoreDataManager.favoritesDictionary[dictionaryKey]! as? [CDStore],
                  let castedData = data as? CDStore else { return }
            foundDuplicate = favoritesCategoryList.contains(where: {$0.id == castedData.id})
        case is CDTruck.Type:
            guard let favoritesCategoryList = CoreDataManager.favoritesDictionary[dictionaryKey]! as? [CDTruck],
                  let castedData = data as? CDTruck else { return }
            foundDuplicate = favoritesCategoryList.contains(where: {$0.id == castedData.id})
        case is CDCredits.Type:
            guard let favoritesCategoryList = CoreDataManager.favoritesDictionary[dictionaryKey]! as? [CDCredits],
                  let castedData = data as? CDCredits else { return }
            foundDuplicate = favoritesCategoryList.contains(where: {$0.id == castedData.id})
        case is CDBurger.Type:
            guard let favoritesCategoryList = CoreDataManager.favoritesDictionary[dictionaryKey]! as? [CDBurger],
                  let castedData = data as? CDBurger else { return }
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

    // swiftlint:disable cyclomatic_complexity
    // swiftlint:disable:next function_body_length
    func configureCell(forIndexPath indexPath: IndexPath, atTable tableView: UITableView) -> UITableViewCell {
        switch dataList[0] {
        case is CharacterModel:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: K.Identifiers.listCellWithImage,
                for: indexPath) as? ListViewCellWithImage else { return UITableViewCell() }
            cell.backgroundColor = .clear
            guard let character = dataList[indexPath.row] as? CharacterModel else { return cell }
            cell.cellImageView.load(url: character.imageURL)
            cell.cellLabel.text = character.name
            return cell
        case is EpisodeModel:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: K.Identifiers.listCell,
                for: indexPath) as? ListViewCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            guard let episode = dataList[indexPath.row] as? EpisodeModel else { return cell }
            cell.cellMainLabel.text = episode.name
            cell.cellAdditionLabel.text = "Season: \(episode.season) / Episode: \(episode.episode)"
            return cell
        case is StoreModel:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: K.Identifiers.listCellWithImage,
                for: indexPath) as? ListViewCellWithImage else { return UITableViewCell() }
            cell.backgroundColor = .clear
            guard let store = dataList[indexPath.row] as? StoreModel else { return cell }
            cell.cellImageView.load(url: store.imageURL)
            cell.cellLabel.text = store.name
            return cell
        case is PestControlTruckModel:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: K.Identifiers.listCellWithImage,
                for: indexPath) as? ListViewCellWithImage else { return UITableViewCell() }
            cell.backgroundColor = .clear
            guard let truck = dataList[indexPath.row] as? PestControlTruckModel else { return cell }
            cell.cellImageView.load(url: truck.imageURL)
            cell.cellLabel.text = truck.name
            return cell
        case is EndCreditsModel:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: K.Identifiers.listCellWithImage,
                for: indexPath) as? ListViewCellWithImage else { return UITableViewCell() }
            cell.backgroundColor = .clear
            guard let credits = dataList[indexPath.row] as? EndCreditsModel else { return cell }
            cell.cellImageView.load(url: credits.imageURL)
            cell.cellLabel.text = "Season: \(credits.season) Episode: \(credits.episode)"
            return cell
        case is BurgerOfTheDayModel:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: K.Identifiers.listCell,
                for: indexPath) as? ListViewCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            guard let burger = dataList[indexPath.row] as? BurgerOfTheDayModel else { return cell }
            cell.cellMainLabel.text = burger.name
            cell.cellAdditionLabel.text = "Seaseon: \(burger.season) Episode: \(burger.episode)"
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: K.Identifiers.listCell,
                for: indexPath) as? ListViewCell else { return UITableViewCell() }
            return cell
        }
    }

    func configureViewController(forData data: Any) -> DetailedInfoController {
        let viewController = DetailedInfoController()
        if let data = data as? CharacterModel {
            viewController.title = "Character's Info"
            viewController.fillUI(with: data)
            viewController.addWebButton(withLink: data.wikiURL)
        }
        if let data = data as? EpisodeModel {
            viewController.title = "Episode Info"
            viewController.fillUI(with: data)
            viewController.addWebButton(withLink: data.wikiURL)
        }
        if let data = data as? StoreModel {
            viewController.title = "Store Info"
            viewController.fillUI(with: data)
        }
        if let data = data as? PestControlTruckModel {
            viewController.title = "Truck Info"
            viewController.fillUI(with: data)
        }
        if let data = data as? EndCreditsModel {
            viewController.title = "End Credits Info"
            viewController.fillUI(with: data)
        }
        if let data = data as? BurgerOfTheDayModel {
            viewController.title = "Burger Info"
            viewController.fillUI(with: data)
        }
        return viewController
    }

    // swiftlint:disable cyclomatic_complexity
    // swiftlint:disable:next function_body_length
    func proceedSavingToFavorites(toCategory category: String?, fromRow index: Int) {
        switch category {
        case "Characters List":
            guard let character = dataList[index] as? CharacterModel else { return }
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
            guard let episode = dataList[index] as? EpisodeModel  else { return }
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
            guard let store = dataList[index] as? StoreModel  else { return }
            let newFavorite = CDStore(context: CoreDataManager.context)
            newFavorite.id = Int64(store.id)
            newFavorite.name = store.name
            newFavorite.season = Int64(store.season)
            newFavorite.episode = Int64(store.episode)
            newFavorite.imageURL = store.imageURL
            checkForDuplicate(of: newFavorite, at: .stores)
        case "Trucks List":
            guard let truck = dataList[index] as? PestControlTruckModel  else { return }
            let newFavorite = CDTruck(context: CoreDataManager.context)
            newFavorite.id = Int64(truck.id)
            newFavorite.name = truck.name
            newFavorite.season = Int64(truck.season)
            newFavorite.imageURL = truck.imageURL
            checkForDuplicate(of: newFavorite, at: .trucks)
        case "End Credits List":
            guard let credits = dataList[index] as? EndCreditsModel  else { return }
            let newFavorite = CDCredits(context: CoreDataManager.context)
            newFavorite.id = Int64(credits.id)
            newFavorite.episode = Int64(credits.episode)
            newFavorite.season = Int64(credits.season)
            newFavorite.imageURL = credits.imageURL
            checkForDuplicate(of: newFavorite, at: .credits)
        case "Burgers List":
            guard let burger = dataList[index] as? BurgerOfTheDayModel  else { return }
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

    // swiftlint:disable:next cyclomatic_complexity
    func searchData(forRequest request: String) {
        dataList = fullList
        if request == "" {
            dataList = fullList
            return
        }
        switch link {
        case .charactersList:
            guard let castedList = dataList as? [CharacterModel] else { return }
            dataList = castedList.filter { $0.name.lowercased().contains(request) }
        case .episodesList:
            guard let castedList = dataList as? [EpisodeModel] else { return }
            dataList = castedList.filter { $0.name.lowercased().contains(request) }
        case .nextDoorStoresList:
            guard let castedList = dataList as? [StoreModel] else { return }
            dataList = castedList.filter { ($0.name ?? "").lowercased().contains(request) }
        case .pestControllTrucksList:
            guard let castedList = dataList as? [PestControlTruckModel] else { return }
            dataList = castedList.filter { ($0.name ?? "").lowercased().contains(request) }
        case .endCreditsList:
            guard let castedList = dataList as? [EndCreditsModel] else { return }
            dataList = castedList.filter { String($0.id).contains(request) }
        case .burgersOfTheDayList:
            guard let castedList = dataList as? [BurgerOfTheDayModel] else { return }
            dataList = castedList.filter { $0.name.lowercased().contains(request) }
        }
    }
}
