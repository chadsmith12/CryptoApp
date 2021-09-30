//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/26/21.
//

import Combine
import Foundation

class HomeViewModel : ObservableObject {
    @Published var statistics: [Statistic] = []
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellabes = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        // this combines to subscribe to the allCoins publisher
        // with this, allCoins will also be updated when coins are retrieved
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] coins in
                self?.allCoins = coins
            }
            .store(in: &cancellabes)
        
        // updates the market data
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] stats in
                self?.statistics = stats
            }
            .store(in: &cancellabes)
        
        // updates portfolio coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (coins, portfolio) in
                coins.compactMap { coin -> Coin? in
                    guard let entity = portfolio.first(where: {$0.coinID == coin.id}) else {
                        return nil
                    }
                    
                    return coin.updateHoldings(amount: entity.amount)
                }
            }
            .sink { [weak self] coins in
                self?.portfolioCoins = coins
            }
            .store(in: &cancellabes)
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
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
    
    private func mapGlobalMarketData(marketData: MarketData?) -> [Statistic] {
        var stats: [Statistic] = []
        guard let data = marketData else {
            return stats
        }
        
        let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChanged: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "24h Volume", value: data.volume)
        let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        let portfolio = Statistic(title: "Portfolio Value", value: "$0.00", percentageChanged: 0)
        
        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
        
        return stats
    }
}
