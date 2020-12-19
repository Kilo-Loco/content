//
//  ContentView.swift
//  chatty
//
//  Created by Kilo Loco on 12/18/20.
//

import Amplify
import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    let didProvideUser: (User) -> Void
    
    var body: some View {
        VStack {
            TextField("Username", text: $viewModel.username)
            Button("Login", action: { viewModel.login(completion: didProvideUser) })
        }
    }
}

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var username = ""
        
        func login(completion: @escaping (User) -> Void) {
            Amplify.DataStore.query(
                User.self,
                where: User.keys.username == username
            ) { result in
                switch(result) {
                case .success(let users):
                    if let user = users.first {
                        DispatchQueue.main.async {
                            completion(user)
                        }
                    } else {
                        
                        let newUser = User(
                            username: self.username)
                        Amplify.DataStore.save(newUser) { result in
                            switch(result) {
                            case .success(let createdUser):
                                print("Saved item: \(createdUser.id)")
                                completion(createdUser)
                                
                                
                            case .failure(let error):
                                print("Could not save item to DataStore: \(error)")
                            }
                        }
                        
                        
                        
                        
                    }
                    
                case .failure(let error):
                    print("Could not query DataStore: \(error)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(didProvideUser: {_ in})
    }
}
