//
//  DetailToolbar.swift
//  CryptoApp
//
//  Created by Chad Smith on 10/6/21.
//

import SwiftUI

struct DetailToolbar: View {
    let coin: Coin
    var body: some View {
        HStack {
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(.theme.secondaryText)
            CoinImage(coin: coin)
                .frame(width: 25, height: 25)
        }
    }
}

struct DetailToolbar_Previews: PreviewProvider {
    static var previews: some View {
        DetailToolbar(coin: dev.coin)
    }
}
