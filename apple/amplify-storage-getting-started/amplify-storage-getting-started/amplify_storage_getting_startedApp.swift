//
//  amplify_storage_getting_startedApp.swift
//  amplify-storage-getting-started
//
//  Created by Kilo Loco.
//

import Amplify
import AmplifyPlugins
import SwiftUI

@main
struct amplify_storage_getting_startedApp: App {
    
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
            // Storage
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSS3StoragePlugin())
            
            try Amplify.configure()
            
            print("Successfully configured Amplify 😁")
            
        } catch {
            print("Could not configure Amplify", error)
        }
    }
    
}
