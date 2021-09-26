//
//  CircleButtonAnimation.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/25/21.
//

import SwiftUI

struct CircleButtonAnimation: View {
    @Binding var animate: Bool
    var duration: Double = 1.0
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.5)
            .opacity(animate ? 0.0 : 0.5)
            .animation(animate ? .easeOut(duration: duration) : .none)
    }
}

struct CircleButtonAnimation_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimation(animate: .constant(false))
            .foregroundColor(.red)
            .previewLayout(.fixed(width: 100, height: 100))
    }
}
