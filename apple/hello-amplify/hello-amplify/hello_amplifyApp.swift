//
//  hello_amplifyApp.swift
//  hello-amplify
//
//  Created by Kilo Loco on 1/10/23.
//

import Amplify
import SwiftUI

@main
struct hello_amplifyApp: App {
    
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
            try Amplify.configure()
            print("Successfully configured Amplify")
            
        } catch {
            print("Could not configure Amplify", error)
        }
    }
}
