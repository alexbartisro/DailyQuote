//
//  QuoteView.swift
//  DailyQuote
//
//  Created by Alexandru Bartis on 09.11.2022.
//

import SwiftUI

struct QuoteView: View {
    @State private var quoteViewModel = QuoteViewModel()
    private let manager = QuoteManager()
    
    #if os(iOS)
    var font: Font = .title2
    #else
    var font: Font = .subheadline
    #endif
    
    var body: some View {
        VStack {
            if let quote = quoteViewModel.quote {
                Image(systemName: "quote.bubble.fill")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                    .padding(.bottom)
                VStack {
                    Text(quote.quote)
                        .font(font)
                        .padding([.leading, .trailing])
                    HStack {
                        Spacer()
                        Text(quote.author)
                            .italic()
                            .padding()
                    }
                }
            } else {
                ProgressView()
            }
        }.onAppear {
            quoteViewModel.viewLoaded()
        }
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView()
    }
}
