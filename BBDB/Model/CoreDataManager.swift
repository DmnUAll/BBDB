import UIKit
import CoreData

struct CoreDataManager {
    
    static var favoritesArray = [Any]()
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Data Manipulation Methods

    static func saveFavorites() {
        do {
            try context.save()
        } catch {
            print("Error saving cintext: \(error)")
        }
    }

    static func loadFavorites(with request: NSFetchRequest<Character> = Character.fetchRequest()) {
        do {
            favoritesArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context: \(error)")
        }
    }
}
