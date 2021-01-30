//
//  ContentView.swift
//  amplify-ios-sign-in
//
//  Created by Kilo Loco on 1/29/21.
//

import Amplify
import SwiftUI

struct ContentView: View {
    @State var emailCode = ""
    @State var authStatus = ""
    
    var body: some View {
        VStack(spacing: 100) {
            Text(authStatus).bold()
            
            Button("Get Status", action: fetchCurrentAuthSession)
            
            Button("Sign Up", action: signUp)
            
            VStack {
                TextField("Email Code", text: $emailCode)
                    .frame(width: 200)
                Button("Confirm Sign Up", action: confirmSignUp)
            }
            
            Button("Sign In", action: signIn)
        }
    }
    
    func fetchCurrentAuthSession() {
        Amplify.Auth.fetchAuthSession { result in
            switch result {
            case .success(let session):
                print("Is user signed in - \(session.isSignedIn)")
                
                if session.isSignedIn {
                    authStatus = "User is signed in"
                } else {
                    authStatus = "User is signed out"
                }
                
            case .failure(let error):
                print("Fetch session failed with error \(error)")
            }
        }
    }
    
    let username = "Kilo_Loco"
    let password = "Password1"
    let email = "kyleez@amazon.com"
    
    func signUp() {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        
        Amplify.Auth.signUp(
            username: username,
            password: password,
            options: options
        ) { result in
            switch result {
            case .success(let signUpResult):
                
                switch signUpResult.nextStep {
                case .confirmUser(let details, let info):
                    print(details ?? "no details", info ?? "no additional info")
                    authStatus = "Need to confirm \(username)'s email"
                    
                case .done:
                    authStatus = "Sign up complete"
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func confirmSignUp() {
        Amplify.Auth.confirmSignUp(for: username, confirmationCode: emailCode) { result in
            
            switch result {
            
            case .success(let confirmSignUpResult):
                
                switch confirmSignUpResult.nextStep {
                case .confirmUser(let details, let info):
                    print(details ?? "no details", info ?? "no additional info")
                    authStatus = "some more steps to go \(String(describing: details))"
                    
                case .done:
                    authStatus = "\(username) confirmed their email"
                }
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func signIn() {
        Amplify.Auth.signIn(username: username, password: password) { result in
            switch result {
            
            case .success:
                authStatus = "\(username) signed in"
                
            case .failure(let error):
                print(error)
                authStatus = "Failed to sign in \(username)"
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
