//
//  String.swift
//  CryptoApp
//
//  Created by Chad Smith on 10/7/21.
//

import Foundation

extension String {
    var removingHTMLOccurences: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
