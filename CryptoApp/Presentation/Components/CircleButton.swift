//
//  CircleButton.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/25/21.
//

import SwiftUI

struct CircleButton: View {
    let iconName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .font(.headline)
                .foregroundColor(.theme.accent)
                .frame(width: 50, height: 50)
                .background(
                    Circle()
                        .foregroundColor(.theme.background)
                )
                .shadow(color: .theme.accent.opacity(0.25), radius: 10, x: 0, y: 0)
                .padding()
        }
    }
}

struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButton(iconName: "info") {
                // do nothing
            }
                .previewLayout(.sizeThatFits)
            CircleButton(iconName: "info") {
                // do nothing
            }
                .previewLayout(.sizeThatFits)
                .colorScheme(.dark)
        }

    }
}
