//
//  UIImage+DominantColor.swift
//  jj-sotd
//
//  Created by Javier Friedman on 7/26/25.
//

// UIImage+DominantColor.swift
import SwiftUI
import UIKit
import UIImageColors

extension UIImage {
    func extractDominantColor(completion: @escaping (Color?, Color?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let colors = self.getColors(), let uiColor = colors.background else {
                DispatchQueue.main.async { completion(nil, nil) }
                return
            }

            let brightness = uiColor.brightness
            let foreground: UIColor = brightness > 0.6 ? .black : .white

            DispatchQueue.main.async {
                completion(Color(uiColor), Color(foreground))
            }
        }
    }
}

extension UIColor {
    var brightness: CGFloat {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (0.299 * red + 0.587 * green + 0.114 * blue)
    }
}

// Image+UIImage.swift
extension Image {
    func asUIImage() -> UIImage? {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = CGSize(width: 260, height: 260)
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
        }
    }
}
