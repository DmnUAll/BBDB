import UIKit

extension UIImage {
    
    class func loadImage(withName name: String) -> UIImage {
        let url = Bundle.main.url(forResource: name, withExtension: "jpg") ?? Bundle.main.url(forResource: name, withExtension: "png")!
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                return image
            }
        }
        return UIImage()
    }
    
    func mergeImage(with secondImage: UIImage, point: CGPoint? = nil) -> UIImage {
        let targetSize = self.size.width < secondImage.size.width ? self.size : secondImage.size
        let firstImage = self.scalePreservingAspectRatio(targetSize: targetSize)
        let secondImage = secondImage.scalePreservingAspectRatio(targetSize: targetSize)
        
        let newImageWidth = min(firstImage.size.width, secondImage.size.width)
        let newImageHeight = firstImage.size.height + secondImage.size.height
        let newImageSize = CGSize(width: newImageWidth, height: newImageHeight)
        UIGraphicsBeginImageContextWithOptions(newImageSize, false, UIScreen.main.scale)
        
        let firstImagePoint = CGPoint(x: 0, y: 0)
        let secondImagePoint = point ?? CGPoint(x: round((newImageSize.width - secondImage.size.width) / 2), y: firstImage.size.height)
        
        firstImage.draw(at: firstImagePoint)
        secondImage.draw(at: secondImagePoint)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image ?? self
    }
    
    private func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        let scaleFactor = min(widthRatio, heightRatio)
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )
        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        return scaledImage
    }
    
    func fixOrientation() -> UIImage {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRectMake(0, 0, self.size.width, self.size.height))
        guard let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage()}
        UIGraphicsEndImageContext()
        return normalizedImage
    }
}
