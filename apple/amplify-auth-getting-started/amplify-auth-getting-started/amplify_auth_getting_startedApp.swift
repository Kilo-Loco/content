//
//  amplify_auth_getting_startedApp.swift
//  amplify-auth-getting-started
//
//  Created by Kilo Loco.
//

import Amplify
import AmplifyPlugins
import SwiftUI

@main
struct amplify_auth_getting_startedApp: App {
    
    init() {
        configureAmplify()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    func configureAmplify() {
        do {
            // Auth
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            
            try Amplify.configure()
            print("Configured Amplify successfully! 😁")
            
        } catch {
            print("Failed to configure Amplify 😤")
        }
    }
}
