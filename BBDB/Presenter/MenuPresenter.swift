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
        viewController?.navigationController?.pushViewController(ListController(for: .charactersList), animated: true)
    }
    
    func episodesButtonTapped() {
        viewController?.navigationController?.pushViewController(ListController(for: .episodesList), animated: true)

    }
    
    func nextDoorStoresButtonTapped() {
        viewController?.navigationController?.pushViewController(ListController(for: .nextDoorStoresList), animated: true)
    }
    
    func pestControlTrucksButtonTapped() {
        viewController?.navigationController?.pushViewController(ListController(for: .pestControllTrucksList), animated: true)
    }
    
    func endCreditsSequenceButtonTapped() {
        viewController?.navigationController?.pushViewController(ListController(for: .endCreditsList), animated: true)
    }
    
    func burgersOfTheDayButtonTapped() {
        viewController?.navigationController?.pushViewController(ListController(for: .burgersOfTheDayList), animated: true)
    }
    
    
}
