import Foundation

// MARK: - UserDefaultsManager
final class UserDefaultsManager {
    
    static var shared = UserDefaultsManager()
    
    private enum Keys: String {
        case appSound, appVolume
    }

    private let userDefaults = UserDefaults.standard

    private(set) var appSound: Bool {
        get {
            loadUserDefaults(for: .appSound, as: Bool.self) ?? true
        }
        set {
            saveUserDefaults(value: newValue, at: .appSound)
        }
    }
    private(set) var appVolume: Float {
        get {
            loadUserDefaults(for: .appVolume, as: Float.self) ?? 0.02
        }
        set {
            saveUserDefaults(value: newValue, at: .appVolume)
        }
    }
    
    // MARK: - Data Manipulation Methods
    private func loadUserDefaults<T: Codable>(for key: Keys, as dataType: T.Type) -> T? {
        guard let data = userDefaults.data(forKey: key.rawValue),
              let count = try? JSONDecoder().decode(dataType.self, from: data) else {
            return nil
        }
        return count
    }
    
    private func saveUserDefaults<T: Codable>(value: T,at key: Keys) {
        guard let data = try? JSONEncoder().encode(value) else {
            print("Unable to save data")
            return
        }
        userDefaults.set(data, forKey: key.rawValue)
    }
    
    func setSound(toState state: Bool) {
        appSound = state
    }
    
    func setVolume(toValue value: Float) {
        appVolume = value
    }
}
