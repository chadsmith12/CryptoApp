//
//  CoinLogoList.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/28/21.
//

import SwiftUI

struct CoinLogoList: View {
    @Binding var selectedCoin: Coin?
    @EnvironmentObject var homeVm: HomeViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(homeVm.allCoins) { coin in
                    Button(action: {
                        withAnimation(.easeIn) {
                            self.selectedCoin = coin
                        }
                    }) {
                        CoinLogoView(coin: coin)
                            .frame(width: 75)
                            .padding(4)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedCoin?.id == coin.id ?  Color.theme.green : Color.clear, lineWidth: 1)
                            )
                    }
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }
    }
}

struct CoinLogoList_Previews: PreviewProvider {
    static var previews: some View {
        CoinLogoList(selectedCoin: .constant(dev.coin))
            .environmentObject(dev.homeVm)
    }
}
