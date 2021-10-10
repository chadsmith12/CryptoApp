//
//  LaunchView.swift
//  CryptoApp
//
//  Created by Chad Smith on 10/9/21.
//

import SwiftUI

struct LaunchView: View {
    @State private var loadingText = "Loading your portfolio...".map { String($0) }
    @State private var showLoadingText = false
    @State private var counter = 0
    @State private var loops = 0
    @Binding var showLaunchView: Bool
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.launch.background
                .ignoresSafeArea()
            
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
            
            ZStack {
                if showLoadingText {
//                    Text(loadingText)
//                        .font(.headline)
//                        .fontWeight(.heavy)
//                        .foregroundColor(.launch.accent)
//                        .transition(AnyTransition.scale.animation(.easeIn))
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(.launch.accent)
                                .offset(y: counter == index ? -5 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y: 70)
        }
        .onAppear {
            self.showLoadingText.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                let lastIndex = self.loadingText.count - 1
                if lastIndex == counter {
                    counter = 0
                    loops += 1
                    if loops >= 2 {
                        showLaunchView = false
                    }
                } else {
                    counter += 1
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}
