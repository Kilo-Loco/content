//
//  push_notifications_iosApp.swift
//  push-notifications-ios
//
//  Created by Kilo Loco on 1/9/21.
//

import Amplify
import AmplifyPlugins
import SwiftUI

class DeviceTokenManager {
    private init() {}
    static let shared = DeviceTokenManager()
    
    var deviceToken: String?
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let token = deviceToken
            .map { String(format: "%02.2hhx", $0) }
            .joined()
        
        DeviceTokenManager.shared.deviceToken = token
    }
}


@main
struct push_notifications_iosApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @State var notificationService = NotificationService()
    
    init() {
        configureAmplify()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: notificationService.requestPermission)
        }
    }
    
    func configureAmplify() {
        do {
            let models = AmplifyModels()
            try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: models))
            try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: models))
            
            try Amplify.configure()
            
            print("Configured amplify")
        } catch {
            print(error)
        }
    }
    
}
