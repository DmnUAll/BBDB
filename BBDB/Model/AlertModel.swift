import Foundation

import UIKit

struct AlertModel {
    var title: String
    var message: String
    var buttonText: String
    var completionHandler: ((UIAlertAction) -> Void)?
}