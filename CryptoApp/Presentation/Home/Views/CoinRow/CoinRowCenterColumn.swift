//
//  CoinRowCenterColumn.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/26/21.
//

import SwiftUI

struct CoinRowCenterColumn: View {
    let coin: Coin
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimal())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(.theme.accent)
    }
}

struct CoinRowCenterColumn_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowCenterColumn(coin: dev.coin)
    }
}
