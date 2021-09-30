//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/28/21.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var homeVm: HomeViewModel
    @State private var selectedCoin: Coin?
    @State private var quantityText: String = ""
    @State private var showCheckMark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $homeVm.searchText)
                    CoinLogoList(selectedCoin: $selectedCoin, quantityText: $quantityText)
                    
                    if selectedCoin != nil {
                        VStack(spacing: 20) {
                            HStack {
                                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""): ")
                                Spacer()
                                Text("\(selectedCoin?.currentPrice.asCurrencyWith6Decimal() ?? "")")
                            }
                            Divider()
                            HStack {
                                Text("Amount holding: ")
                                Spacer()
                                TextField("Ex. 1.4", text: $quantityText)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.decimalPad)
                            }
                            Divider()
                            HStack {
                                Text("Current Value: ")
                                Spacer()
                                Text(getCurrentValue().asCurrencyWith2Decimal())
                            }
                        }
                        .animation(.none)
                        .padding()
                        .font(.headline)
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    XMarkButton() {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    HStack(spacing: 10) {
                        Image(systemName: "checkmark")
                            .opacity(showCheckMark ? 1.0 : 0.0)
                        
                        Button {
                            saveButtonPress()
                        } label: {
                            Text("Save".uppercased())
                        }
                        .opacity((selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0)
                    }
                    .font(.headline)
                }
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVm)
    }
}

extension PortfolioView {
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        
        return 0
    }
    
    private func saveButtonPress() {
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else {
            return
        }
        
        // save to portfolio here
        homeVm.updatePortfolio(coin: coin, amount: amount)
        
        withAnimation(.easeIn) {
            showCheckMark = true
            removeSelectedCoin()
        }
        
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                self.showCheckMark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        homeVm.searchText = ""
    }
}
