//
//  QuoteViewModel.swift
//  DailyQuote
//
//  Created by Alexandru Bartis on 09.11.2022.
//

import Foundation

struct QuoteViewModel {
    private let quoteManager = QuoteManager()
    var quote: Quote?
    
    mutating func viewLoaded() {
        self.quote = quoteManager.getSingleQuote()
    }
}
