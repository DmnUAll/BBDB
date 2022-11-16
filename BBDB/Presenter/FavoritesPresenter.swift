import UIKit
import CoreData

class FavoritesPresenter {
    
    weak var viewController: FavoritesController?
    
    init(viewController: FavoritesController) {
        self.viewController = viewController
        viewController.favoritesView.delegate = self
    }
}

// MARK: - FeedViewDelegate

extension FavoritesPresenter: FavoritesViewDelegate {
    func aboutFavoritesButtonTapped() {
        viewController?.showAboutFavoritesAlert()
    }
    
    func aboutAppButtonTapped() {
        viewController?.showAboutAppAlert()
    }
}
