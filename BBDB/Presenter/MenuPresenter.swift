import UIKit

// MARK: - MenuPresenter
final class MenuPresenter {

    // MARK: - Properties and Initializers
    private weak var viewController: MenuController?

    init(viewController: MenuController) {
        self.viewController = viewController
        viewController.menuView.delegate = self
    }
}

// MARK: - MenuViewDelegate
extension MenuPresenter: MenuViewDelegate {
    func charactersButtonTapped() {
        viewController?.show(ListController(for: .charactersList), sender: nil)
    }

    func episodesButtonTapped() {
        viewController?.show(ListController(for: .episodesList), sender: nil)
    }

    func nextDoorStoresButtonTapped() {
        viewController?.show(ListController(for: .nextDoorStoresList), sender: nil)
    }

    func pestControlTrucksButtonTapped() {
        viewController?.show(ListController(for: .pestControllTrucksList), sender: nil)
    }

    func endCreditsSequenceButtonTapped() {
        viewController?.show(ListController(for: .endCreditsList), sender: nil)
    }

    func burgersOfTheDayButtonTapped() {
        viewController?.show(ListController(for: .burgersOfTheDayList), sender: nil)
    }
}
