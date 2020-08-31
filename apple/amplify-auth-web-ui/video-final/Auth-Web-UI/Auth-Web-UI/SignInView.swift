//
//  SignInView.swift
//  Auth-Web-UI
//
//  Created by Kyle Lee on 8/3/20.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var auth: AuthService
    
    var body: some View {
        Button("Sign In", action: auth.webSignIn)
            .padding()
            .background(Color.purple)
            .foregroundColor(.white)
            .cornerRadius(3)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
