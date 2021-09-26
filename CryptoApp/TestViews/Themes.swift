//
//  Themes.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/25/21.
//

import SwiftUI

struct Themes: View {
    var body: some View {
        ZStack {
            Color.theme.background
            
            VStack {
                Text("Accent Color")
                    .foregroundColor(.theme.accent)
                Text("Secondary Text Color")
                    .foregroundColor(.theme.secondaryText)
                Text("Red Color")
                    .foregroundColor(.theme.red)
                Text("Green Color")
                    .foregroundColor(.theme.green)
            }
        }
        .ignoresSafeArea()
    }
}

struct Themes_Previews: PreviewProvider {
    static var previews: some View {
        Themes()
            .preferredColorScheme(.dark)
    }
}
