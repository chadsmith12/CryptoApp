//
//  CoinDetailDataService.swift
//  CryptoApp
//
//  Created by Chad Smith on 10/2/21.
//

import Combine
import Foundation

class CoinDetailDataService {
    @Published var coinDetail: CoinDetail?
    var coinDetailSubscription: AnyCancellable?
    let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetail.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] coinDetail in
                self?.coinDetail = coinDetail
                self?.coinDetailSubscription?.cancel()
            })
    }
}
