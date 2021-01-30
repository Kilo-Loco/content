//
//  ContributionsGraphView.swift
//  not-github
//
//  Created by Kilo Loco on 1/27/21.
//

import SwiftUI

struct ContributionsGraphView: View {
    
    static let boxSize: CGFloat = 15
    static let spacing: CGFloat = 4
    
    private let rows = Array(
        repeating: GridItem(.fixed(boxSize), spacing: spacing),
        count: 7
    )
    
    let days: [DevelopmentDay]
    let selectedDay: (DevelopmentDay) -> Void
    
    func GitHubColor(for count: Int) -> Color {
        if count > 15 {
            return Color(red: 0.867, green: 0.525, blue: 1)
        } else if count > 10 {
            return Color(red: 0.651, green: 0.310, blue: 0.765)
        } else if count > 5 {
            return Color(red: 0.498, green: 0.157, blue: 0.6)
        } else if count > 0 {
            return Color(red: 0.345, green: 0, blue: 0.435)
        } else {
            return Color.clear
        }
    }
    
    var body: some View {
        LazyHGrid(rows: rows, spacing: Self.spacing) {
            ForEach(days, id: \.date) { day in
                GitHubColor(for: day.dataCount)
                    .frame(width: Self.boxSize, height: Self.boxSize)
                    .border(Color(.tertiarySystemBackground), width: day.dataCount == 0 ? 1 : 0)
                    .cornerRadius(2)
                    .onTapGesture {
                        selectedDay(day)
                    }
            }
        }
    }
}
