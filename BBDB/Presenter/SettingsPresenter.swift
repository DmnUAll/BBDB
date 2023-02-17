import UIKit
import Kingfisher

final class SettingsPresenter {
    
    weak var viewController: SettingsController?
    
    init(viewController: SettingsController) {
        self.viewController = viewController
        viewController.settingsView.delegate = self
    }
}

// MARK: - SettingsViewDelegate
extension SettingsPresenter: SettingsViewDelegate {
    
    func clearKFCache() {
        let cache = ImageCache.default
        cache.clearMemoryCache()
        cache.clearDiskCache()
    }
    
    func soundStateChanged(to state: Bool) {
        UserDefaultsManager.shared.setSound(toState: state)
        guard let tabBarController = viewController?.tabBarController as? TabBarController else { return }
        guard state else {
            tabBarController.player.stop()
            return
        }
        tabBarController.player.play()
    }
    
    func splashStateChanged(to state: Bool) {
        UserDefaultsManager.shared.setSplashScreen(toState: state)
    }
    
    func volumeValueChanged(to value: Float) {
        print(value)
        UserDefaultsManager.shared.setVolume(toValue: value)
        guard let tabBarController = viewController?.tabBarController as? TabBarController else { return }
        tabBarController.player.volume = value
    }
}
