//
//  chattyApp.swift
//  chatty
//
//  Created by Kilo Loco on 12/18/20.
//

import Amplify
import AmplifyPlugins
import SwiftUI

@main
struct chattyApp: App {
    
    public init() {
        let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
        //let apiPlugin = AWSAPIPlugin(modelRegistration: AmplifyModels()) // UNCOMMENT this line once backend is deployed

        do {
            try Amplify.add(plugin: dataStorePlugin)
            //try Amplify.add(plugin: apiPlugin) // UNCOMMENT this line once backend is deployed
            try Amplify.configure()
            print("Initialized Amplify");
        } catch {
            print("Could not initialize Amplify: \(error)")
        }
    }
    
    
    @State var user: User?
    
    var body: some Scene {
        WindowGroup {
            
            if let currentUser = user {
                MessagesView(currentUser: currentUser)
                
                
            } else {
                ContentView { user in
                    self.user = user
                }
            }
        }
    }
}
