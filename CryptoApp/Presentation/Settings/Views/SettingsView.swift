//
//  SettingsView.swift
//  CryptoApp
//
//  Created by Chad Smith on 10/7/21.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("CoinGecko"), content: {
                    VStack(alignment: .leading) {
                        Image("coingecko")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        Text("The cryptocurrency data that this app uses comes from a free API from CoinGecko! The prices may be slightly delayed.")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundColor(.theme.accent)
                    }
                    .padding(.vertical)
                    
                    Link("Visit CoinGecko", destination: URL(string: "https://www.coingecko.com/en")!)
                        .accentColor(.blue)
                })
            }
            .navigationTitle("App Info")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    XMarkButton {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
