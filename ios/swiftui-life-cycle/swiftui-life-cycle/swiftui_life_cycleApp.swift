//
//  swiftui_life_cycleApp.swift
//  swiftui-life-cycle
//
//  Created by Kyle Lee on 9/22/20.
//

import SwiftUI

@main
struct swiftui_life_cycleApp: App {
    
    @UIApplicationDelegateAdaptor(MyAppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var scenePhase
    
    init() {
        // configure library
        doSomething()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("active")
            case .inactive:
                print("inactive")
            case .background:
                print("background")
            @unknown default:
                print("something new added by apple")
            }
        }
    }
    
    func doSomething() {
        
    }
}
