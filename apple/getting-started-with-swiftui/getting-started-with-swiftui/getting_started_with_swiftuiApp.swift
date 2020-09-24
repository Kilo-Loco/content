//
//  getting_started_with_swiftuiApp.swift
//  getting-started-with-swiftui
//
//  Created by Kyle Lee on 9/22/20.
//

import Combine
import SwiftUI

@main
struct getting_started_with_swiftuiApp: App {
   
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @Environment(\.scenePhase) var phase
    
    init() {
        // configure some resource here
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onReceive(
                    NotificationCenter.default.publisher(for: Notification.Name("shortcut"))
                ) { notification in
        //            self.shortcut = notification.object as? Shortcut
                    print(notification)
                }
        }
        .onChange(of: phase) { event in
            switch event {
            case .active:
                print("app is active")
            default:
                print("app is not active")
            }
        }
        
    }
}
