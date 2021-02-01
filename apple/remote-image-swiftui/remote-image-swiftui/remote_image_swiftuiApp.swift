//
//  remote_image_swiftuiApp.swift
//  remote-image-swiftui
//
//  Created by Kilo Loco on 1/31/21.
//

import Amplify
import AmplifyPlugins
import SwiftUI

@main
struct remote_image_swiftuiApp: App {
    
    init() {
        configureAmplify()
        AmplifyService.signInIfNeeded()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func configureAmplify() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSS3StoragePlugin())
            
            try Amplify.configure()
            print("Successfully configured Amplify")
            
        } catch {
            print("Could not configure Amplify", error)
        }
    }
}
