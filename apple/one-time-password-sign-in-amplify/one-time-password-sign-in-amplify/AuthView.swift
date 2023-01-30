//
//  AuthView.swift
//  one-time-password-sign-in-amplify
//
//  Created by Kilo Loco on 1/30/23.
//

import SwiftUI

struct AuthView: View {
    
    @State var isSignedIn: Bool = false
    @State var shouldShowSignUp: Bool = false
    
    var body: some View {
        if isSignedIn {
            Text("Welcome to the Amplify App")
                .font(.title)
        } else {
            if shouldShowSignUp {
                SignUpView {
                    shouldShowSignUp = false
                }
            } else {
                LoginView {
                    shouldShowSignUp = true
                } didLogin: {
                    isSignedIn = true
                }
            }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
