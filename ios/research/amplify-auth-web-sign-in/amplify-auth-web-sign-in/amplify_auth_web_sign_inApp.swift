//
//  amplify_auth_web_sign_inApp.swift
//  amplify-auth-web-sign-in
//
//  Created by Kyle Lee on 7/27/20.
//

import Amplify
import AmplifyPlugins
import SwiftUI

@main
struct amplify_auth_web_sign_inApp: App {
    
    @ObservedObject private var auth = AuthService()
    
    init() {
        configureAmplify()
        auth.fetchAuthSession()
        auth.observeAuth()
    }
    
    var body: some Scene {
        WindowGroup {
            if auth.isSignedIn {
                SessionView()
                    .environmentObject(auth)
            } else {
                ContentView()
                    .environmentObject(auth)
            }
        }
    }
    
    private func configureAmplify() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            print("amplify configured")
            
        } catch {
            print(error)
        }
    }
    
}
