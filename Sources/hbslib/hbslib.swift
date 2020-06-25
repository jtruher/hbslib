import UIKit

struct hbslib {
    var text = "Hello, World!"
}

extension UIView {
    func applyAutolayoutHugging() {
        if let sv = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: sv.topAnchor),
                self.bottomAnchor.constraint(equalTo: sv.bottomAnchor),
                self.leftAnchor.constraint(equalTo: sv.leftAnchor),
                self.rightAnchor.constraint(equalTo: sv.rightAnchor),
            ])
        }
    }
}

extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
    static func convertBase64StringToImage(imageBase64String : String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        
        return image!
    }
}
