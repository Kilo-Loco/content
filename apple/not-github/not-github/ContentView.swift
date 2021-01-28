//
//  ContentView.swift
//  not-github
//
//  Created by Kilo Loco on 1/27/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            ContributionsGraphView(
                days: viewModel.days,
                selectedDay: { viewModel.selectedDay = $0 }
            )
            
            if let selectedDay = viewModel.selectedDay {
                Text("You made \(selectedDay.dataCount) contribution(s) on \(DateService.shared.dateFormatter.string(from: selectedDay.date))")
            }
        }
    }
}

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var days = [DevelopmentDay]()
        @Published var selectedDay: DevelopmentDay?
        
        init() {
            getDevelopmentDays()
        }
        
        private func getDevelopmentDays() {
            GitHubParser.getDevelopmentDays(for: "kilo-loco") { [weak self] days in
                self?.days = days
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
