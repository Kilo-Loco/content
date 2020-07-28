//
//  ContentView.swift
//  amplify-auth-web-sign-in
//
//  Created by Kyle Lee on 7/27/20.
//

import Amplify
import SwiftUI

struct SessionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Spacer()
            Text("You have signed in")
            Spacer()
            Button("Sign Out", action: signOut)
        }
    }
    
    private func signOut() {
        _ = Amplify.Auth.signOut { result in
            switch result {
            case .success:
                print("Signed out")
                presentationMode.wrappedValue.dismiss()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}


struct ContentView: View {
    
    @State private var isSignedIn = false
    
    private var window: UIWindow {
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
            .sheet(isPresented: $isSignedIn) {
                SessionView()
            }
            .onAppear(perform: fetchAuthSession)
    }
    
    private func fetchAuthSession() {
        _ = Amplify.Auth.fetchAuthSession { result in
            switch result {
            case .success(let session):
                DispatchQueue.main.async {
                    isSignedIn = session.isSignedIn
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func signIn() {
        _ = Amplify.Auth.signInWithWebUI(presentationAnchor: window) { result in
            switch result {
            case .success(let signInResult):
                DispatchQueue.main.async {
                    isSignedIn = signInResult.isSignedIn
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
