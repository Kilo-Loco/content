//
//  ContentView.swift
//  amplify-auth-getting-started
//
//  Created by Kilo Loco on 10/8/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var authStatus: String?
    
    var body: some View {
        VStack {
            if let authStatus = self.authStatus {
                Text(authStatus).padding()
            }
            Button("Get Status", action: {}).padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
