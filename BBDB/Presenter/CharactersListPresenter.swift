import UIKit


class CharactersListPresenter {
    
    private let charactersLoader: CharactersLoading
    weak var viewController: CharactersListController?
    
    init(viewController: CharactersListController) {
        self.viewController = viewController
        charactersLoader = CharactersLoader()
        loadData()
    }
    
    func loadData() {
        charactersLoader.loadCharacters { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let charactersList):
                    self.viewController?.characters = charactersList
                    self.viewController?.listView.fillAndReloadTable()
                case .failure(let error):
                    self.viewController?.showNetworkError(message: error.localizedDescription)
                }
            }
        }
    }
}
