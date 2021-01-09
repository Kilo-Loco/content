//
//  ContentView.swift
//  push-notifications-ios
//
//  Created by Kilo Loco on 1/9/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            TextField("Enter a message", text: $viewModel.messageText)
            
            Button("Send", action: viewModel.sendMessage)
        }
        .padding()
    }
}

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var messageText = ""
        
        func sendMessage() {
            print(messageText)
            messageText.removeAll()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
