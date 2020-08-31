//
//  Auth_Web_UIApp.swift
//  Auth-Web-UI
//
//  Created by Kyle Lee on 7/28/20.
//

import Amplify
import AmplifyPlugins
import SwiftUI

@main
struct Auth_Web_UIApp: App {
    
    @ObservedObject var auth = AuthService()
    
    init() {
        configureAmplify()
        auth.checkSessionStatus()
        auth.observeAuthEvents()
    }
    
    var body: some Scene {
        WindowGroup {
            if auth.isSignedIn {
                SessionView()
                    .environmentObject(auth)
            } else {
                SignInView()
                    .environmentObject(auth)
            }
        }
    }
    
    private func configureAmplify() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            print("Amplify configured")
            
        } catch {
            print("Could not initialize Amplify -", error)
        }
    }
}
