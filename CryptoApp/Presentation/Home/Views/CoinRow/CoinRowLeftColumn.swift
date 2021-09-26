//
//  CoinRowLeftColumn.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/26/21.
//

import SwiftUI

struct CoinRowLeftColumn: View {
    let coin: Coin
    
    var body: some View {
        HStack(spacing: 0) {
            Text(String(coin.rank))
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
                .frame(minWidth: 30)
            Circle()
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(.theme.accent)
        }
    }
}

struct CoinRowLeftColumn_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowLeftColumn(coin: dev.coin)
    }
}
