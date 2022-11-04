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
    func aboutMenuButtonTapped() {
        viewController?.showAboutMenuAlert()
    }
    
    func aboutAppButtonTapped() {
        viewController?.showAboutAppAlert()
    }
    
    func charactersButtonTapped() {
        print(#function)
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
