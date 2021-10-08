//
//  ExpandableText.swift
//  CryptoApp
//
//  Created by Chad Smith on 10/7/21.
//

import SwiftUI

struct ExpandableText: View {
    private var text: String
    private var lineLimit: Int
    @Binding var showFullText: Bool
    
    init(_ text: String, showFullText: Binding<Bool>, lineLimit: Int = 3) {
        self.text = text
        self._showFullText = showFullText
        self.lineLimit = lineLimit
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(text)
                .lineLimit(showFullText ? nil : lineLimit)
                .font(.callout)
                .foregroundColor(.theme.secondaryText)
            Button {
                withAnimation(.easeInOut) {
                    self.showFullText.toggle()
                }
            } label: {
                Text(showFullText ? "Less" : "Read More...")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.vertical, 4)
            }
            .accentColor(.blue)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ExpandableText_Previews: PreviewProvider {
    static var previews: some View {
        ExpandableText("Read more", showFullText: .constant(false))
    }
}
