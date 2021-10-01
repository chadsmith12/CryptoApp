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
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(.degrees(vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
            }
            
            Spacer()
            if showPortfolio {
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0)
                        .rotationEffect(.degrees(vm.sortOption == .holdings ? 0 : 180))

                }
                .onTapGesture {
                    vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                }
            }
            
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(.degrees(vm.sortOption == .price ? 0 : 180))

            }
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                .onTapGesture {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(.degrees(vm.isLoading ? 360 : 0), anchor: .center)
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
