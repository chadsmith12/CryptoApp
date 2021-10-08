//
//  DetailViewModel.swift
//  CryptoApp
//
//  Created by Chad Smith on 10/2/21.
//

import Combine
import Foundation

class DetailViewModel: ObservableObject {
    @Published var coinDetails: CoinDetail?
    @Published var coin: Coin
    @Published var overviewStats: [Statistic] = []
    @Published var additionalStats: [Statistic] = []
    @Published var description: String? = nil
    @Published var websiteUrl: String? = nil
    @Published var redditUrl: String? = nil
    
    private let coinDetailService: CoinDetailDataService
    private var cancellabes = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coin = coin
        coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetail
            .combineLatest($coin)
            .map(mapStats)
            .sink { [weak self] (overview: [Statistic], additional: [Statistic]) in
                self?.overviewStats = overview
                self?.additionalStats = additional
            }
            .store(in: &cancellabes)
        
        coinDetailService.$coinDetail
            .sink { [weak self] coinDetail in
                self?.description = coinDetail?.readabeDescription
                self?.websiteUrl = coinDetail?.links.homepage.first
                self?.redditUrl = coinDetail?.links.subredditUrl
            }
            .store(in: &cancellabes)
    }
    
    var coinName: String {
        coin.name
    }
    
    private func mapStats(_ coinDetail: CoinDetail?, _ coin: Coin) -> (overview: [Statistic], additional: [Statistic]) {
        let overview = mapOverviewStats(coin: coin)
        let additional = mapAdditionalStats(coinDetail: coinDetail, coin: coin)
        
        return (overview:overview, additional: additional)
    }
    
    private func mapOverviewStats(coin: Coin) -> [Statistic] {
        let price = coin.currentPrice.asCurrencyWith6Decimal()
        let pricePercentChange = coin.priceChangePercentage24H
        let priceStat = Statistic(title: "Current Price", value: price, percentageChanged: pricePercentChange)
        
        let marketCap = "$\(coin.marketCap?.formattedWithAbbreviations() ?? "")"
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketCapStat = Statistic(title: "Market Capitialization", value: marketCap, percentageChanged: marketCapPercentChange)
        
        let rank = "\(coin.rank)"
        let rankStat = Statistic(title: "Rank", value: rank)
        
        let volume = "$\(coin.totalVolume?.formattedWithAbbreviations() ?? "")"
        let volumeStat = Statistic(title: "Volume", value: volume)
    
        return [priceStat, marketCapStat, rankStat, volumeStat]
    }
    
    private func mapAdditionalStats(coinDetail: CoinDetail?, coin: Coin) -> [Statistic] {
        let high = coin.high24H?.asCurrencyWith6Decimal() ?? "N/A"
        let highStat = Statistic(title: "24h High", value: high)
        
        let low = coin.low24H?.asCurrencyWith6Decimal() ?? "N/A"
        let lowStat = Statistic(title: "24h Low", value: low)
        
        let priceChange = coin.priceChange24H?.asCurrencyWith6Decimal() ?? "N/A"
        let pricePercentChange2 = coin.priceChangePercentage24H
        let priceChangeStat = Statistic(title: "24h Price Change", value: priceChange, percentageChanged: pricePercentChange2)
        
        let blockTime = coinDetail?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a": "\(blockTime)"
        let blockStat = Statistic(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetail?.hashingAlgorithm ?? "n/a"
        let hashingStat = Statistic(title: "Hashing Algorithm", value: hashing)
        
        return [highStat, lowStat, priceChangeStat, blockStat, hashingStat]
    }
}
