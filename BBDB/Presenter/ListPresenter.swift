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
}
