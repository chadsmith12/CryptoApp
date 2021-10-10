//
//  MarketDataService.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/28/21.
//

import Combine
import Foundation

class MarketDataService {
    @Published var marketData: MarketData?
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getMarketData()
    }
    
    func getMarketData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {
            return
        }
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: MarketDataResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnMarketData in
                self?.marketData = returnMarketData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
