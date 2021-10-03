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
    
    private let coinDetailService: CoinDetailDataService
    private var cancellabes = Set<AnyCancellable>()
    
    init(coin: Coin) {
        coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetail
            .sink { [weak self] coinDetails in
                self?.coinDetails = coinDetails
            }
            .store(in: &cancellabes)
    }
}
