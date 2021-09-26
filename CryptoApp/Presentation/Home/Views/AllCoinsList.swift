//
//  AllCoinsList.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/26/21.
//

import SwiftUI

struct AllCoinsList: View {
    @EnvironmentObject var vm: HomeViewModel
    
    var body: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct AllCoinsList_Previews: PreviewProvider {
    static var previews: some View {
        AllCoinsList()
            .environmentObject(dev.homeVm)
    }
}
