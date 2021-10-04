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
    @ObservedObject var vm: DetailViewModel
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private var spacing: CGFloat = 30
    
    
    init(coin: Coin) {
        self.vm = DetailViewModel(coin: coin)
    }
        
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("")
                    .frame(height: 250)
                
                Text("Overview")
                    .font(.title)
                    .bold()
                    .foregroundColor(.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                
                LazyVGrid(columns: columns, alignment: .leading, spacing: spacing, pinnedViews: []) {
                    ForEach(vm.overviewStats) { stat in
                        StatisticView(stat: stat)
                    }
                }
                
                Text("Additional Details")
                    .font(.title)
                    .bold()
                    .foregroundColor(.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                LazyVGrid(columns: columns, alignment: .leading, spacing: spacing, pinnedViews: []) {
                    ForEach(vm.additionalStats) { stat in
                        StatisticView(stat: stat)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(vm.coinName)
    }
}

struct MainDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainDetailView(coin: dev.coin)
        }
    }
}
