import UIKit

extension UIFont {
    
    enum AppFonts: String {
        case empty = "Bob'sBurgers2"
        case filled = "Bob'sBurgers"
    }

    static func appFont(_ style: AppFonts, withSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: style.rawValue, size: size) else {
            return UIFont.systemFont(ofSize: 18)
        }
        return font
    }
}
