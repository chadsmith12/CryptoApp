//
//  CoinImage.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/26/21.
//

import SwiftUI

struct CoinImage: View {
    @StateObject var vm: CoinImageViewModel
    
    init(coin: Coin) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            else if vm.isLoading {
                ProgressView()
            }
            else {
                Image(systemName: "questionmark")
                    .foregroundColor(.theme.secondaryText)
            }
        }
    }
}

struct CoinImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinImage(coin: dev.coin)
                .previewLayout(.sizeThatFits)
                .padding()
        }

    }
}
