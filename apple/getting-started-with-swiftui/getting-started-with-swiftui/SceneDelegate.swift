//
//  SceneDelegate.swift
//  getting-started-with-swiftui
//
//  Created by Kyle Lee on 9/22/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private var shortcut: Shortcut?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let shortcut = Shortcut(rawValue: connectionOptions.shortcutItem?.localizedTitle ?? "") else { return }
        self.shortcut = shortcut
    }
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        guard let shortcut = Shortcut(rawValue: shortcutItem.localizedTitle.lowercased()) else {
            completionHandler(false)
            return
        }
        
        self.shortcut = shortcut
        completionHandler(true)
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        guard let shortcut = self.shortcut else { return }
        let notification = Notification(name: Notification.Name("shortcut"), object: shortcut)
        NotificationCenter.default.post(notification)
        self.shortcut = nil
    }
    
}
