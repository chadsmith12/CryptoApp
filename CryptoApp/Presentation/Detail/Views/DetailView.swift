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
    @State private var showDescription = false
    
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
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                VStack(spacing: 20) {
                    Text("Overview")
                        .font(.title)
                        .bold()
                        .foregroundColor(.theme.accent)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                    ZStack {
                        if let coinDescription = vm.description, !coinDescription.isEmpty {
                            ExpandableText(coinDescription, showFullText: $showDescription)
                        }
                    }
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
                    VStack(alignment: .leading, spacing: 20) {
                        if let website = vm.websiteUrl, let url = URL(string: website) {
                            Link("Website", destination: url)
                        }
                        
                        if let redditString = vm.redditUrl, let redditUrl = URL(string: redditString) {
                            Link("Reddit", destination: redditUrl)
                        }
                    }
                    .accentColor(.blue)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                    
                    
                }
                .padding()
            }
        }
        .navigationTitle(vm.coinName)
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                DetailToolbar(coin: vm.coin)
            }
        }
    }
}

struct MainDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainDetailView(coin: dev.coin)
        }
    }
}
