//
//  DetailView.swift
//  CryptoApp
//
//  Created by Chad Smith on 10/1/21.
//

import SwiftUI

struct DetailView: View {
    let coin: Coin?
    
    var body: some View {
        ZStack {
            if coin != nil {
                MainDetailView(coin: coin!)
            }
        }
    }
}

struct MainDetailView: View {
    let coin: Coin
        
    var body: some View {
        Text(coin.name)
    }
}

struct MainDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MainDetailView(coin: dev.coin)
    }
}
