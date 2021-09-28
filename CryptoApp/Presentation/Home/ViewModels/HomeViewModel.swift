//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/26/21.
//

import Combine
import Foundation

class HomeViewModel : ObservableObject {
    @Published var statistics: [Statistic] = [
        Statistic(title: "Title", value: "Value", percentageChanged: 1),
        Statistic(title: "Title", value: "Value"),
        Statistic(title: "Title", value: "Value"),
        Statistic(title: "Title", value: "Value", percentageChanged: -7)
    ]
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    private var cancellabes = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        // this combines to subscribe to the allCoins publisher
        // with this, allCoins will also be updated when coins are retrieved
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] coins in
                self?.allCoins = coins
            }
            .store(in: &cancellabes)
    }
    
    private func filterCoins(text: String, startingCoins: [Coin]) -> [Coin] {
        guard !text.isEmpty else {
            return startingCoins
        }
        
        let lowerCaseText = text.lowercased()
        return startingCoins.filter { coin in
            coin.name.lowercased().contains(lowerCaseText)
            || coin.symbol.lowercased().contains(lowerCaseText)
            || coin.id.lowercased().contains(lowerCaseText)
        }
    }
}
