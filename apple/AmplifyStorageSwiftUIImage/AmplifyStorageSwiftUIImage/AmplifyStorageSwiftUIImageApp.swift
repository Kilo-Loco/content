//
//  AmplifyStorageSwiftUIImageApp.swift
//  AmplifyStorageSwiftUIImage
//
//  Created by Kilo Loco on 9/28/22.
//

import Amplify
import AWSCognitoAuthPlugin
import AWSS3StoragePlugin
import SwiftUI

@main
struct AmplifyStorageSwiftUIImageApp: App {
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
