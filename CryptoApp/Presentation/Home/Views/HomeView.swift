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
    @State private var showInfoView = false
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                }
            
            VStack {
                HomeHeader(showPortfolio: $showPortfolio, showPortfolioView: $showPortfolioView, showInfoView: $showInfoView)
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
                    ZStack(alignment: .top) {
                        if vm.portfolioCoins.isEmpty && vm.searchText.isEmpty {
                            Text("Portfolio is empty. Click the + button to get started")
                                .font(.callout)
                                .foregroundColor(.theme.accent)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .padding(50)
                        } else {
                            PortfolioCoinsList()
                        }
                    }
                    .transition(.move(edge: .trailing))
                }
               
                Spacer(minLength: 0)
            }
            .sheet(isPresented: $showInfoView) {
                SettingsView()
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
