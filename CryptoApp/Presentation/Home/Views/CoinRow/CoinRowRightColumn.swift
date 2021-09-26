//
//  CoinRowRightColumn.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/26/21.
//

import SwiftUI

struct CoinRowRightColumn: View {
    let coin: Coin
    
    var body: some View {
        VStack {
            Text(coin.currentPrice.asCurrencyWith6Decimal())
                .bold()
                .foregroundColor(.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? .theme.green : .theme.red)
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}

struct CoinRowRightColumn_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowRightColumn(coin: dev.coin)
    }
}
