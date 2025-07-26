//
//  MusicPlatformButton.swift
//  jj-sotd
//
//  Created by Javier Friedman on 7/26/25.
//

import Foundation

import SwiftUI

struct MusicPlatformButton: View {
    let icon: String
    let size: CGFloat
    let foreground: Color
    let action: () -> Void

    @GestureState private var isPressed = false

    var body: some View {
        Button(action: action) {
            Image(icon)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
                .foregroundColor(foreground)
                .padding(10)
                .background(foreground.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(foreground.opacity(0.2), lineWidth: 1)
                )
                .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .gesture(
            DragGesture(minimumDistance: 0)
                .updating($isPressed) { _, state, _ in
                    state = true
                }
        )
    }
}
