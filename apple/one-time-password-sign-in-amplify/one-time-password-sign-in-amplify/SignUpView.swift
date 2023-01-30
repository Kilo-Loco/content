//
//  SignUpView.swift
//  one-time-password-sign-in-amplify
//
//  Created by Kilo Loco on 1/30/23.
//

import SwiftUI

struct SignUpView: View {
    
    let shouldShowLogin: () -> Void
    
    @State var username: String = ""
    @State var email: String = ""
    @State var confirmSignUpIsVisible: Bool = false
    
    var body: some View {
        VStack(spacing: 16) {
            Image("amplify-logo-large")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250)
            
            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)
            
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
            
            Button("Sign Up", action: {})
                .buttonStyle(.borderedProminent)
            
            Button(
                "Already have an account? Login.",
                action: shouldShowLogin
            )
            .padding()
            
            Spacer()
        }
        .padding(.horizontal, 32)
        .sheet(isPresented: $confirmSignUpIsVisible) {
            ConfirmSignUpView(didConfirmSignUp: shouldShowLogin)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(shouldShowLogin: {})
    }
}
