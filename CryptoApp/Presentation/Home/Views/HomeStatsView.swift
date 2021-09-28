//
//  HomeStatsView.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/28/21.
//

import SwiftUI

struct HomeStatsView: View {
    @Binding var showPortfolio: Bool
    @EnvironmentObject var homeVm: HomeViewModel
    
    var body: some View {
        HStack {
            ForEach(homeVm.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPortfolio: .constant(false))
            .environmentObject(dev.homeVm)
    }
}
