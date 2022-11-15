import UIKit


class ListPresenter {
    
    private let listLoader: NetworkDataLoading
    weak var viewController: ListController?
    private let link: Link
    var dataList: [Any] = []
    
    init(viewController: ListController, link: Link) {
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
    
}
