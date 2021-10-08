//
//  CoinDetail.swift
//  CryptoApp
//
//  Created by Chad Smith on 10/2/21.
//

import Foundation

struct CoinDetail: Identifiable, Codable {
    let id, symbol, name: String
    let blockTimeInMinutes: Int
    let hashingAlgorithm: String?
    let description: Description
    let links: Links
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
        case description
        case links
    }
    
    var readabeDescription: String {
        description.en.removingHTMLOccurences
    }
}

struct Description: Codable {
    let en: String
}

struct Links: Codable {
    let homepage: [String]
    let subredditUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case homepage
        case subredditUrl = "subreddit_url"
    }
}
