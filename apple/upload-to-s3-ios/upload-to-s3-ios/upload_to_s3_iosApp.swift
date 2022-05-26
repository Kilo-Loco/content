//
//  upload_to_s3_iosApp.swift
//  upload-to-s3-ios
//
//  Created by Kilo Loco on 2/17/22.
//

import Amplify
import AWSCognitoAuthPlugin
import AWSS3StoragePlugin
import SwiftUI

@main
struct upload_to_s3_iosApp: App {
    
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
            try Amplify.add(plugin: AWSS3StoragePlugin())
            
            try Amplify.configure()
            print("Successfully configured Amplify")
            
        } catch {
            print("Could not configure Amplify", error)
        }
    }
}
