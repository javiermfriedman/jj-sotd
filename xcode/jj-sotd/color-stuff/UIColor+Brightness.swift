//
//  UIColor+Brightness.swift
//  jj-sotd
//
//  Created by Javier Friedman on 7/26/25.
//

import Foundation
import UIKit

extension UIColor {
    var isDarkColor: Bool {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        guard self.getRed(&r, green: &g, blue: &b, alpha: &a) else {
            return false // fallback: assume not dark
        }

        // Perceived luminance formula
        let luminance = 0.299 * r + 0.587 * g + 0.114 * b
        return luminance < 0.5
    }
}
