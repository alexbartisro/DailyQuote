//
//  QuoteManager.swift
//  DailyQuote
//
//  Created by Alexandru Bartis on 09.11.2022.
//

import Foundation

class QuoteManager {
    private var quotes = [Quote]()
    
    public func getSingleQuote() -> Quote {
        if quotes.isEmpty {
            quotes = getQuotes().quotes
        }
        
        return quotes.randomElement() ?? Quote(quote: "Couldn't find anything", author: "The Dev")
    }
    
    private func getQuotes() -> Quotes {
        guard let urlPath = Bundle.main.url(forResource: "Quotes", withExtension: "json") else {
            return Quotes(quotes: [Quote]())
        }
        
        do {
            let data = try Data(contentsOf: urlPath)
            return try JSONDecoder().decode(Quotes.self, from: data)
        } catch {
            print("can't load data")
        }
        
        return Quotes(quotes: [Quote]())
    }
}
