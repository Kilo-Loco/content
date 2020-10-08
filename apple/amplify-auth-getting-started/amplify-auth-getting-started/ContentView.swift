//
//  ContentView.swift
//  amplify-auth-getting-started
//
//  Created by Kilo Loco.
//

import Amplify
import SwiftUI

struct ContentView: View {
    
    @State var authStatus: String?
    
    var body: some View {
        VStack {
            if let authStatus = self.authStatus {
                Text(authStatus).padding()
            }
            Button("Get Status", action: checkAuthStatus).padding()
        }
    }
    
    func checkAuthStatus() {
        Amplify.Auth.fetchAuthSession { (result) in
            switch result {
            case .success(let authSession):
                print("The current user is signed in: \(authSession.isSignedIn)")
                if authSession.isSignedIn {
                    authStatus = "User is signed in"
                } else {
                    authStatus = "User is signed out"
                }
                
            case .failure(let authError):
                print("Failed to fetch the Auth Session", authError)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
