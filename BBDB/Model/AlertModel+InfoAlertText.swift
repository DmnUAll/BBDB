import UIKit

// MARK: - AlertModel
struct AlertModel {
    var title: String
    var message: String
    var buttonText: String
    var completionHandler: ((UIAlertAction) -> Void)?
}

// MARK: - InfoAlertText
enum InfoAlertText: String {
    case aboutApp = """
    
    This App was made by me:
    https://github.com/DmnUAll
    
    Based on API:
    https://bobs-burgers-api-ui.herokuapp.com
    """
    case aboutFeed = "\nThis feed will show you 5 random characters per day.\nBuy full version to see 5 random characters per run!"
    case aboutMenu = "\nThis menu allows you to watch the full info list of any provided category."
    case aboutFavorites = "\n Here stores all items that you're added to your favorites list!"
    case aboutWhoAmI = "\nThis section allows you to know - which character from 'Bob's Burgers' suits you."
}
