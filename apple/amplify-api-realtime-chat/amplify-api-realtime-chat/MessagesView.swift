//
//  MessagesView.swift
//  amplify-api-realtime-chat
//
//  Created by Kilo Loco on 10/12/20.
//

import SwiftUI

struct MessagesView: View {
    
    @State var text = String()
    @ObservedObject var sot = SourceOfTruth()
    
    let currentUser = "Kilo Loco"
    
    init() {
        sot.getMessages()
        sot.observeMessages()
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(sot.messages) { message in
                        MessageRow(
                            message: message,
                            isCurrentUser: message.senderName == currentUser
                        )
                    }
                }
            }
            
            HStack {
                TextField("Enter message", text: $text)
                Button("Send", action: didTapSend)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.purple)
            }
        }
        .padding(.horizontal, 16)
    }
    
    func didTapSend() {
        print(text)
        
        let message = Message(
            senderName: currentUser,
            body: text,
            creationDate: Int(Date().timeIntervalSince1970)
        )
        sot.send(message)
        
        text.removeAll()
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
