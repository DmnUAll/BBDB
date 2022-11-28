import UIKit
import CoreData

struct CoreDataManager {
    
    enum Categories {
        case characters
        case episodes
        case stores
        case trucks
        case credits
        case burgers
    }
    
    static var favoritesDictionary: [Categories: [Any]] = [.characters: [],
                                                           .episodes: [],
                                                           .stores: [],
                                                           .trucks: [],
                                                           .credits: [],
                                                           .burgers: []
    ]
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Data Manipulation Methods
    
    static func saveFavorites() {
        do {
            try context.save()
        } catch {
            print("Error saving cintext: \(error)")
        }
    }
    
    static func loadAll() {
        loadFavorites(with: CDBurger.fetchRequest())
        loadFavorites(with: CDCredits.fetchRequest())
        loadFavorites(with: CDTruck.fetchRequest())
        loadFavorites(with: CDStore.fetchRequest())
        loadFavorites(with: CDEpisode.fetchRequest())
        loadFavorites(with: CDCharacter.fetchRequest())
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    static func loadFavorites(with request: NSFetchRequest<NSFetchRequestResult>) {
        switch request.entityName {
        case "CDCharacter":
            do {
                favoritesDictionary[.characters] = try context.fetch(request)
            } catch {
                print("Error fetching data from context: \(error)")
            }
        case "CDEpisode":
            do {
                favoritesDictionary[.episodes] = try context.fetch(request)
            } catch {
                print("Error fetching data from context: \(error)")
            }
        case "CDStore":
            do {
                favoritesDictionary[.stores] = try context.fetch(request)
            } catch {
                print("Error fetching data from context: \(error)")
            }
        case "CDTruck":
            do {
                favoritesDictionary[.trucks] = try context.fetch(request)
            } catch {
                print("Error fetching data from context: \(error)")
            }
        case "CDCredits":
            do {
                favoritesDictionary[.credits] = try context.fetch(request)
            } catch {
                print("Error fetching data from context: \(error)")
            }
        case "CDBurger":
            do {
                favoritesDictionary[.burgers] = try context.fetch(request)
            } catch {
                print("Error fetching data from context: \(error)")
            }
        default:
            return
        }
    }
}
