import UIKit
import SwiftUI

extension UIImage {
    func dominantColor() -> UIColor? {
        guard let cgImage = self.cgImage else { return nil }

        // Resize image to reduce computation
        let size = CGSize(width: 10, height: 10)
        UIGraphicsBeginImageContext(size)
        defer { UIGraphicsEndImageContext() }

        self.draw(in: CGRect(origin: .zero, size: size))
        guard let contextImage = UIGraphicsGetImageFromCurrentImageContext(),
              let contextCGImage = contextImage.cgImage,
              let data = contextCGImage.dataProvider?.data,
              let ptr = CFDataGetBytePtr(data) else {
            return nil
        }

        var colorCounts = [UInt32: Int]()
        for x in 0..<10 {
            for y in 0..<10 {
                let pixelIndex = ((contextCGImage.bytesPerRow * y) + x * 4)
                let r = ptr[pixelIndex]
                let g = ptr[pixelIndex + 1]
                let b = ptr[pixelIndex + 2]
                let a = ptr[pixelIndex + 3]

                if a < 127 { continue } // skip mostly transparent pixels

                let color = (UInt32(r) << 16) | (UInt32(g) << 8) | UInt32(b)
                colorCounts[color, default: 0] += 1
            }
        }

        if let (color, _) = colorCounts.max(by: { $0.value < $1.value }) {
            let r = CGFloat((color >> 16) & 0xFF) / 255.0
            let g = CGFloat((color >> 8) & 0xFF) / 255.0
            let b = CGFloat(color & 0xFF) / 255.0
            return UIColor(red: r, green: g, blue: b, alpha: 1.0)
        }

        return nil
    }

    var isDarkColor: Bool {
        guard let dominant = self.dominantColor() else { return false }

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        dominant.getRed(&r, green: &g, blue: &b, alpha: &a)

        // Calculate luminance
        let luminance = (0.299 * r + 0.587 * g + 0.114 * b)
        return luminance < 0.5
    }
}
