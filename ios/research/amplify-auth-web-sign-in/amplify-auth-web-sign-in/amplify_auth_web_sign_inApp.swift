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
    
    init() {
        configureAmplify()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
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
