import UIKit

class MenuPresenter {
    
    weak var viewController: MenuController?
    
    init(viewController: MenuController) {
        self.viewController = viewController
        viewController.menuView.delegate = self
    }
}

// MARK: - MenuViewDelegate

extension MenuPresenter: MenuViewDelegate {
    func charactersButtonTapped() {
        print(#function)
        viewController?.navigationController?.pushViewController(CharactersListController(), animated: true)
    }
    
    func episodesButtonTapped() {
        print(#function)
    }
    
    func nextDoorStoresButtonTapped() {
        print(#function)
    }
    
    func pestControlTrucksButtonTapped() {
        print(#function)
    }
    
    func endCreditsSequenceButtonTapped() {
        print(#function)
    }
    
    func burgersOfTheDayButtonTapped() {
        print(#function)
    }
    
    
}
