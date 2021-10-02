//
//  PortfolioCoinsList.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/26/21.
//

import SwiftUI

struct PortfolioCoinsList: View {
    @EnvironmentObject var vm: HomeViewModel
    var body: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        navigate(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private func navigate(coin: Coin) {
        
    }
}

struct PortfolioCoinsList_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioCoinsList()
            .environmentObject(dev.homeVm)
    }
}
