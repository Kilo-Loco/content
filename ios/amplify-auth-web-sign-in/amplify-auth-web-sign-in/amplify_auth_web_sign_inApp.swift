//
//  amplify_auth_web_sign_inApp.swift
//  amplify-auth-web-sign-in
//
//  Created by Kyle Lee on 7/27/20.
//

import SwiftUI

@main
struct amplify_auth_web_sign_inApp: App {
    
    var window: UIWindow {
            guard
                let scene = UIApplication.shared.connectedScenes.first,
                let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
                let window = windowSceneDelegate.window as? UIWindow
            else { return UIWindow() }
            
            return window
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
