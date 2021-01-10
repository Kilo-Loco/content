//
//  ContentView.swift
//  push-notifications-ios
//
//  Created by Kilo Loco on 1/9/21.
//

import Amplify
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
            guard let deviceToken = DeviceTokenManager.shared.deviceToken else { return }
            
            print(messageText, deviceToken)
            
            let message = Message(body: messageText, deviceToken: deviceToken)
            
            Amplify.DataStore.save(message) { result in
                switch result {
                case .success(let savedMessage):
                    print("Sent", savedMessage)
                    DispatchQueue.main.async { [weak self] in
                        self?.messageText.removeAll()
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
