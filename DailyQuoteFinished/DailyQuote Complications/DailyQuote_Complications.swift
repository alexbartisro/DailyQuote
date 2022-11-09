//
//  DailyQuote_Complications.swift
//  DailyQuote Complications
//
//  Created by Alexandru Bartis on 09.11.2022.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    private let quoteManager = QuoteManager()
    
    func placeholder(in context: Context) -> QuoteEntry {
        let quote = Quote(quote: "Roses are red", author: "Nobody knows")
        
        return QuoteEntry(date: Date(), quote: quote)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (QuoteEntry) -> ()) {
        if context.isPreview {
            let quote = Quote(quote: "Roses are red", author: "Nobody knows")
            completion(QuoteEntry(date: Date(), quote: quote))
        } else {
            let quote = quoteManager.getSingleQuote()
            completion(QuoteEntry(date: Date(), quote: quote))
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [QuoteEntry] = []
        
        // Generate a timeline consisting of five entries minute apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let quote = quoteManager.getSingleQuote()
            let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset, to: currentDate)!
            let entry = QuoteEntry(date: entryDate, quote: quote)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct QuoteEntry: TimelineEntry {
    let date: Date
    let quote: Quote
}

struct DailyQuote_ComplicationsEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    
    var entry: Provider.Entry
    
    var body: some View {
        switch widgetFamily {
        case .accessoryCorner:
            ComplicationCorner(entry: entry)
        case .accessoryCircular:
            ComplicationCircular(entry: entry)
        case .accessoryInline:
            ComplicationInline(entry: entry)
        case .accessoryRectangular:
            ComplicationRectangular(entry: entry)
        @unknown default:
            //mandatory as there are more widget families as in lockscreen widgets etc
            Text("Not an implemented widget yet")
        }
    }
}

struct ComplicationInline : View {
    var entry: QuoteEntry
    
    var body: some View {
        Text(entry.quote.quote)
            .widgetAccentable(true)
            .unredacted()
    }
}

struct ComplicationCircular : View {
    var entry: QuoteEntry
    
    var body: some View {
        Text(entry.quote.quote)
            .widgetAccentable(true)
            .unredacted()
    }
}

struct ComplicationCorner : View {
    var entry: QuoteEntry
    
    var body: some View {
        Image(systemName:"quote.bubble")
            .widgetLabel {
                Text(entry.quote.quote)
                    .widgetAccentable(true)
            }
            .unredacted()
    }
}

struct ComplicationRectangular : View {
    var entry: QuoteEntry
    
    var body: some View {
        Text(entry.quote.quote)
            .widgetAccentable(true)
            .unredacted()
    }
}

@main
struct DailyQuote_Complications: Widget {
    let kind: String = "ro.bartis.DailyQuote.Complications"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DailyQuote_ComplicationsEntryView(entry: entry)
        }
        .configurationDisplayName("Daily Quote")
        .description("This is a complication that shows you a new quote evey day")
    }
}

struct DailyQuote_Complications_Previews: PreviewProvider {
    static var previews: some View {
        let quote = Quote(quote: "Violets are blue", author: "Nobody knows")
        DailyQuote_ComplicationsEntryView(entry: QuoteEntry(date: Date(), quote: quote))
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
        
        DailyQuote_ComplicationsEntryView(entry: QuoteEntry(date: Date(), quote: quote))
            .previewContext(WidgetPreviewContext(family: .accessoryInline))
        
        DailyQuote_ComplicationsEntryView(entry: QuoteEntry(date: Date(), quote: quote))
            .previewContext(WidgetPreviewContext(family: .accessoryCorner))
        
        DailyQuote_ComplicationsEntryView(entry: QuoteEntry(date: Date(), quote: quote))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
