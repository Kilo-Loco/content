//
//  ContentView.swift
//  amplify-auth-web-sign-in
//
//  Created by Kyle Lee on 7/27/20.
//

import SwiftUI

struct ContentView: View {
    
    var window: UIWindow {
            guard
                let scene = UIApplication.shared.connectedScenes.first,
                let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
                let window = windowSceneDelegate.window as? UIWindow
            else { return UIWindow() }
            
            return window
        }
    
    var body: some View {
        Button("Sign In", action: signIn)
            .padding()
            .background(Color.purple)
            .foregroundColor(.white)
            .cornerRadius(3)
    }
    
    private func signIn() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
