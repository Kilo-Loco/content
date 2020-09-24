//
//  MySceneDelegate.swift
//  swiftui-life-cycle
//
//  Created by Kyle Lee on 9/22/20.
//

import UIKit

class MySceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        print("connecting scene")
    }
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        <#code#>
    }
}
