//
//  Quote.swift
//  DailyQuote
//
//  Created by Alexandru Bartis on 09.11.2022.
//
// Quotes source:  https://gist.github.com/nasrulhazim/54b659e43b1035215cd0ba1d4577ee80

import Foundation

struct Quotes: Codable {
    var quotes: [Quote]
}

struct Quote: Codable {
    let quote: String
    let author: String
}
