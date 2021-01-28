//
//  Not_GitHub_Widget.swift
//  Not GitHub Widget
//
//  Created by Kilo Loco on 1/27/21.
//

import WidgetKit
import SwiftUI

struct ContributionsGraphEntry: TimelineEntry {
    let date: Date
    let days: [DevelopmentDay]
}

struct Provider: TimelineProvider {
    
    private var dummyEntry: ContributionsGraphEntry {
        let now = Date()
        let days = (0 ..< 119).map { index -> DevelopmentDay in
            let date = Calendar.current.date(
                byAdding: .day,
                value: -index,
                to: now
            )!
            return DevelopmentDay(date: date, dataCount: 0)
        }
        return ContributionsGraphEntry(date: now, days: days)
    }
    
    func placeholder(in context: Context) -> ContributionsGraphEntry {
        dummyEntry
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ContributionsGraphEntry) -> Void) {
        completion(dummyEntry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ContributionsGraphEntry>) -> Void) {
        GitHubParser.getDevelopmentDays(for: "kilo-loco") { days in
            let entry = ContributionsGraphEntry(date: Date(), days: days)
            let timeline = Timeline(
                entries: [entry],
                policy: TimelineReloadPolicy.after(Calendar.current.date(byAdding: .day, value: 1, to: Date())!)
            )
            completion(timeline)
        }
    }
}

struct WidgetEntryView: View {
    let entry: Provider.Entry
    
    var body: some View {
        ContributionsGraphView(days: entry.days, selectedDay: {_ in})
    }
}

@main
struct ContributionsGraphWidget: Widget {
    private let kind = "Not_GitHub_Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium])
    }
}

