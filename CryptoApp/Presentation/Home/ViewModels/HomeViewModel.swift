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
    @Published var isLoading: Bool = false
    @Published var sortOption: SortOption = .holdings
    @Published var showingDetailView: Bool = false
    @Published var selectedCoin: Coin? = nil
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellabes = Set<AnyCancellable>()
    
    enum SortOption {
        case rank, rankReversed
        case holdings, holdingsReversed
        case price, priceReversed
    }
    
    init() {
        addSubscribers()
    }

    func addSubscribers() {
        // this combines to subscribe to the allCoins publisher
        // with this, allCoins will also be updated when coins are retrieved
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] coins in
                self?.allCoins = coins
            }
            .store(in: &cancellabes)
        
        // updates portfolio coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] coins in
                guard let self = self else {
                    return
                }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: coins)
            }
            .store(in: &cancellabes)
        
        // updates the market data
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] stats in
                self?.statistics = stats
                self?.isLoading = false
            }
            .store(in: &cancellabes)
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarketData()
        HapticManager.notification(type: .success)
    }
    
    private func filterAndSortCoins(text: String, startingCoins: [Coin], sort: SortOption) -> [Coin] {
        let filteredCoins = filterCoins(text: text, startingCoins: startingCoins)
        let sortedCoins = sortCoins(sort: sort, coins: filteredCoins)
        
        return sortedCoins
    }
    
    private func sortCoins(sort: SortOption, coins: [Coin]) -> [Coin] {
        switch sort {
        case .rank, .holdings, .holdingsReversed:
            return coins.sorted(by: {$0.rank < $1.rank})
        case .rankReversed:
            return coins.sorted(by: {$0.rank > $1.rank})
        case .price:
            return coins.sorted(by: {$0.currentPrice > $1.currentPrice})
        case .priceReversed:
            return coins.sorted(by: {$0.currentPrice < $1.currentPrice})
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [Coin]) -> [Coin] {
        switch sortOption {
        case .holdings:
            return coins.sorted { $0.currentHoldingsValue > $1.currentHoldingsValue }
        case .holdingsReversed:
            return coins.sorted { $0.currentHoldingsValue < $1.currentHoldingsValue }
        default:
            return coins
        }
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
    
    private func mapGlobalMarketData(marketData: MarketData?, portfolioCoins: [Coin]) -> [Statistic] {
        var stats: [Statistic] = []
        guard let data = marketData else {
            return stats
        }
        
        let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChanged: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "24h Volume", value: data.volume)
        let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue = portfolioCoins
            .map({$0.currentHoldingsValue})
            .reduce(0, +)
        
        let previousValue = portfolioCoins
            .map { coin -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentChanged = (coin.priceChangePercentage24H ?? 0) / 100
            let previousValue = currentValue / (1 + percentChanged)
            return previousValue
        }
            .reduce(0, +)
        
        let percentageChanged = ((portfolioValue - previousValue) / previousValue)
        
        let portfolio = Statistic(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimal(), percentageChanged: percentageChanged)
        
        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
        
        return stats
    }
    
    private func mapAllCoinsToPortfolioCoins(_ coins: [Coin], _ portfolio: [Portfolio]) -> [Coin] {
        return coins.compactMap { coin -> Coin? in
            guard let entity = portfolio.first(where: {$0.coinID == coin.id}) else {
                return nil
            }
            
            return coin.updateHoldings(amount: entity.amount)
        }
    }
}
