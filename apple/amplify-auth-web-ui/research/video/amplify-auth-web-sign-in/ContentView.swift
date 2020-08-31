//
//  ContentView.swift
//  amplify-auth-web-sign-in
//
//  Created by Kyle Lee on 7/27/20.
//

import Amplify
import SwiftUI

struct SessionView: View {
    
    @EnvironmentObject var auth: AuthService
    
    var body: some View {
        VStack {
            Spacer()
            Text("You have signed in")
            Spacer()
            Button("Sign Out", action: auth.signOut)
        }
    }
}


struct ContentView: View {
    
    @EnvironmentObject var auth: AuthService
    
    var body: some View {
        Button("Sign In", action: auth.webSignIn)
            .padding()
            .background(Color.purple)
            .foregroundColor(.white)
            .cornerRadius(3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
