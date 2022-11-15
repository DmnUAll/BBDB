import UIKit

extension CGFloat {
    func cornerRadiusAutoSize(divider: CGFloat = 30) -> CGFloat {
        return UIScreen.main.bounds.height / divider
    }
    func textAutoSize(divider: CGFloat = 40) -> CGFloat {
        return UIScreen.main.bounds.height / divider
    }
}
