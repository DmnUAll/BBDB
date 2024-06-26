import UIKit
import CoreData

// MARK: - CoreDataManager
struct CoreDataManager {

    enum Categories: String, CaseIterable {
        case characters = "Characters"
        case episodes = "Episodes"
        case stores = "Next Door Stores"
        case trucks = "Pest Control Trucks"
        case credits = "End Credits"
        case burgers = "Burgers Of The Day"
    }

    static var favoritesDictionary: [Categories: [Any]] = [.characters: [],
                                                           .episodes: [],
                                                           .stores: [],
                                                           .trucks: [],
                                                           .credits: [],
                                                           .burgers: []
    ]
    // swiftlint:disable force_cast
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // swiftlint:enable force_cast

    // MARK: - Data Manipulation Methods
    static func saveFavorites() {
        do {
            try context.save()
        } catch {
            print("\(String.contextSavingError) \(error)")
        }
    }

    static func deleteItem(withKey key: Categories, at index: Int) {
        guard let itemToDelete = (favoritesDictionary[key]?[index]) as? NSManagedObject else { return }
        context.delete(itemToDelete)
        favoritesDictionary[key]?.remove(at: index)
        saveFavorites()
    }

    static func loadAll() {
        loadFavorites(with: CDBurger.fetchRequest())
        loadFavorites(with: CDCredits.fetchRequest())
        loadFavorites(with: CDTruck.fetchRequest())
        loadFavorites(with: CDStore.fetchRequest())
        loadFavorites(with: CDEpisode.fetchRequest())
        loadFavorites(with: CDCharacter.fetchRequest())
    }

    // swiftlint:disable:next cyclomatic_complexity
    static func loadFavorites(with request: NSFetchRequest<NSFetchRequestResult>) {
        switch request.entityName {
        case K.CoreDataEntitiesNames.cdCharacter:
            do {
                favoritesDictionary[.characters] = try context.fetch(request)
            } catch {
                print("\(String.contextDataFetchingError) \(error)")
            }
        case K.CoreDataEntitiesNames.cdEpisode:
            do {
                favoritesDictionary[.episodes] = try context.fetch(request)
            } catch {
                print("\(String.contextDataFetchingError) \(error)")
            }
        case K.CoreDataEntitiesNames.cdStore:
            do {
                favoritesDictionary[.stores] = try context.fetch(request)
            } catch {
                print("\(String.contextDataFetchingError) \(error)")
            }
        case K.CoreDataEntitiesNames.cdTruck:
            do {
                favoritesDictionary[.trucks] = try context.fetch(request)
            } catch {
                print("\(String.contextDataFetchingError) \(error)")
            }
        case K.CoreDataEntitiesNames.cdCredits:
            do {
                favoritesDictionary[.credits] = try context.fetch(request)
            } catch {
                print("\(String.contextDataFetchingError) \(error)")
            }
        case K.CoreDataEntitiesNames.cdBurger:
            do {
                favoritesDictionary[.burgers] = try context.fetch(request)
            } catch {
                print("\(String.contextDataFetchingError) \(error)")
            }
        default:
            return
        }
    }
}

// MARK: - String fileprivate extension
fileprivate extension String {
    static let contextSavingError = "Error saving context:"
    static let contextDataFetchingError = "Error fetching data from context:"
}
