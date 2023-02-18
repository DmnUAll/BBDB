import UIKit

extension UIScreen {

    static func screenHeight(dividedBy divider: CGFloat) -> CGFloat {
        return self.main.bounds.height / divider
    }
}
