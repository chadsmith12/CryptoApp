//
//  CoinImageDataService.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/26/21.
//

import Combine
import Foundation
import UIKit

class CoinImageDataService {
    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    private let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        guard let url = URL(string: coin.image) else {
            return
        }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            })
    }
}
