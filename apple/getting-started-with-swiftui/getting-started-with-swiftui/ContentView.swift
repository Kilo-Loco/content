//
//  ContentView.swift
//  getting-started-with-swiftui
//
//  Created by Kyle Lee on 9/22/20.
//

import Combine
import SwiftUI

enum Shortcut: String {
    case search, share
}

struct ContentView: View {
    @State var shortcut: Shortcut?
    
    var body: some View {
        let text = shortcut?.rawValue ?? "Welcome"
        
        VStack {
            Text(text)
                .padding()
        }
        .onReceive(
            NotificationCenter.default.publisher(for: Notification.Name("shortcut"))
        ) { notification in
            self.shortcut = notification.object as? Shortcut
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
