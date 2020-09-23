//
//  amplify_datastore_storageApp.swift
//  amplify-datastore-storage
//
//  Created by Kyle Lee on 8/7/20.
//

import Amplify
import AmplifyPlugins
import SwiftUI

@main
struct amplify_datastore_storageApp: App {
    
    init() {
        configureAmplify()
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                CameraView()
                    .tabItem { Image(systemName: "camera") }
                GalleryView()
                    .tabItem { Image(systemName: "photo.on.rectangle") }
            }
        }
    }
    
    func configureAmplify() {
        do {
            // Storage
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSS3StoragePlugin())
            
            // DataStore
            let models = AmplifyModels()
            try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: models))
            try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: models))
            
            // Configure Plugins
            try Amplify.configure()
            print("Configured Amplify Successfully!")
            
        } catch {
            print("Could not configure Amplify - \(error)")
        }
    }
}
