//
//  amplify_app_iosApp.swift
//  amplify-app-ios
//
//  Created by Kilo Loco on 10/4/20.
//

import Amplify
import AmplifyPlugins
import AWSPredictionsPlugin
import SwiftUI

@main
struct amplify_app_iosApp: App {
    
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
            
            // Analytics
            try Amplify.add(plugin: AWSPinpointAnalyticsPlugin())
            
            // API
            let models = AmplifyModels()
            try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: models))
            
            // DataStore
            try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: models))
            
            // Predictions
            try Amplify.add(plugin: AWSPredictionsPlugin())
            
            // Storage
            try Amplify.add(plugin: AWSS3StoragePlugin())
            
            // Amplify configure
            try Amplify.configure()
            
            print("Successfully configured Amplify!")
            
        } catch {
            print("Could not initialize Amplify -", error)
        }
    }
}
