//
//  MessagesView.swift
//  chatty
//
//  Created by Kilo Loco on 12/18/20.
//

import Amplify
import SwiftUI

struct MessagesView: View {
    @StateObject var viewModel = ViewModel()
    
    let currentUser: User
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.messages) { message in
                            HStack {
                                
                                let isMessageFromCurrentUser = currentUser.username == message.authorUsername
                                
                                if isMessageFromCurrentUser {
                                    Spacer()
                                }
                                
                                VStack(alignment: isMessageFromCurrentUser ? .trailing : .leading) {
                                    Text(message.authorUsername)
                                        .font(.footnote)
                                    Text(message.body)
                                        .padding()
                                        .foregroundColor(isMessageFromCurrentUser ? .black : .white)
                                        .background(isMessageFromCurrentUser ? Color.gray : Color.blue)
                                        .cornerRadius(10)
                                }
                                
                                if !isMessageFromCurrentUser {
                                    Spacer()
                                }
                            }
                            .rotationEffect(.degrees(180))
                        }
                    }
                }
                .rotationEffect(.degrees(180))
                .padding(.horizontal)
                
                HStack {
                    TextField("Enter a message", text: $viewModel.messageText)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    Button("send", action: viewModel.createMessage)
                }
            }
            .navigationTitle("Messages")
        }
        .onAppear(perform: {
            viewModel.attach(currentUser)
            viewModel.getMessages()
        })
    }
}

extension MessagesView {
    class ViewModel: ObservableObject {
        
        @Published var messageText = ""
        
        @Published var messages = [Message]()
        
        var user: User!
        
        func attach(_ user: User) {
            self.user = user
        }
        
        func getMessages() {
            Amplify.DataStore.query(
                Message.self,
                sort: .descending(Message.keys.creationDate)
            ) { result in
                switch(result) {
                case .success(let items):
                    DispatchQueue.main.async {
                        self.messages = items
                    }
                    
                case .failure(let error):
                    print("Could not query DataStore: \(error)")
                }
            }
        }
        
        func createMessage() {
            let item = Message(
                body: messageText,
                authorUsername: user.username,
                creationDate: Temporal.DateTime(Date())
            )
            Amplify.DataStore.save(item) { result in
                switch(result) {
                case .success(let savedItem):
                    print("Saved item: \(savedItem.id)")
                    self.getMessages()
                    self.messageText = ""
                    
                case .failure(let error):
                    print("Could not save item to DataStore: \(error)")
                }
            }
        }
    }
}
