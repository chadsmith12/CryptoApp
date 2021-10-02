//
//  HomeView.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/25/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio = false
    @State private var showPortfolioView = false
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                }
            
            VStack {
                HomeHeader(showPortfolio: $showPortfolio, showPortfolioView: $showPortfolioView)
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                ListColumnHeaders(showPortfolio: showPortfolio)
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
                .padding(.horizontal)
                if !showPortfolio {
                    AllCoinsList()
                        .transition(.move(edge: .leading))
                }
                if showPortfolio {
                    PortfolioCoinsList()
                        .transition(.move(edge: .trailing))
                }
               
                Spacer(minLength: 0)
            }
        }
        .background(
            NavigationLink(isActive: $vm.showingDetailView, destination: {DetailView(coin: vm.selectedCoin)}, label: {EmptyView()})
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVm)
        .preferredColorScheme(.dark)
    }
}
