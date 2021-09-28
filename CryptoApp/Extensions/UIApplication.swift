//
//  UIApplication.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/27/21.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
