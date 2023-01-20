//
//  ContentView.swift
//  conditional-modifier
//
//  Created by Kilo Loco on 1/20/23.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

struct ContentView: View {
    @State var isThemed: Bool = false
    
    var body: some View {
        VStack {
            Text("Like and Subscribe")
                .if(isThemed) { view in
                    view.font(.largeTitle)
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.red)
                .cornerRadius(8)
            
            Toggle("Theme Toggle", isOn: $isThemed)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
