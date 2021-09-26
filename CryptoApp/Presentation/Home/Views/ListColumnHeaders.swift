//
//  ListColumnHeaders.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/26/21.
//

import SwiftUI

struct ListColumnHeaders: View {
    @EnvironmentObject var vm: HomeViewModel
    let showPortfolio: Bool
    
    var body: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
    }
}

struct ListColumnHeaders_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ListColumnHeaders(showPortfolio: false)
                .previewLayout(.sizeThatFits)
            ListColumnHeaders(showPortfolio: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        .environmentObject(dev.homeVm)
    }
}
