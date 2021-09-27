//
//  CoinImageViewModel.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/26/21.
//

import Combine
import Foundation
import SwiftUI

class CoinImageViewModel : ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin: Coin
    private let dataService: CoinImageDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coin = coin
        self.isLoading = true
        self.dataService = CoinImageDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] image in
                self?.image = image
            }
            .store(in: &cancellables)

    }
}
