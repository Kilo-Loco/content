//
//  up_and_running_amplify_swiftApp.swift
//  up-and-running-amplify-swift
//
//  Created by Kilo Loco on 1/16/23.
//

import Amplify
import SwiftUI

@main
struct up_and_running_amplify_swiftApp: App {
    
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
