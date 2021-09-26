//
//  HomeHeader.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/26/21.
//

import SwiftUI

struct HomeHeader: View {
    @Binding var showPortfolio: Bool
    private var navTitle: String {
        showPortfolio ? "Portfolio" : "Live Prices"
    }
    
    var body: some View {
        HStack {
            CircleButton(iconName: showPortfolio ? "plus" : "info") {
                
            }
            .background(CircleButtonAnimation(animate: $showPortfolio))
            .animation(.none)
            Spacer()
            Text(navTitle)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.theme.accent)
                .animation(.none)
            Spacer()
            CircleButton(iconName: "chevron.right") {
                withAnimation(.spring()) {
                    self.showPortfolio.toggle()
                }
            }
            .rotationEffect(.degrees(showPortfolio ? 180 : 0))
        }
        .padding(.horizontal)
    }
}

struct HomeHeader_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeader(showPortfolio: .constant(false))
    }
}
