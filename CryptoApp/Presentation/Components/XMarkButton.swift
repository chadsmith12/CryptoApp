//
//  XMarkButton.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/28/21.
//

import SwiftUI

struct XMarkButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton() {
            // do nothing
        }
    }
}
