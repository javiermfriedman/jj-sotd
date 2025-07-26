//
//  ColorAnalyzer.swift
//  jj-sotd
//
//  Created by Javier Friedman on 7/26/25.
//

import Foundation
// ColorAnalyzer.swift

import SwiftUI
import UIKit
import UIImageColors
import SwiftUI
import UIKit

struct ColorAnalyzer {
    static func computeColors(from imageURLString: String, completion: @escaping (Color, Color) -> Void) {
        guard let url = URL(string: imageURLString) else {
            completion(Color(.systemBackground), Color(.label)) // fallback
            return
        }

        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url),
                  let uiImage = UIImage(data: data),
                  let background = uiImage.dominantColor() else {
                DispatchQueue.main.async {
                    completion(Color(.systemBackground), Color(.label))
                }
                return
            }

            let fgColor = background.isDarkColor ? Color.white : Color.black
            DispatchQueue.main.async {
                completion(Color(background), fgColor)
            }
        }
    }
}
