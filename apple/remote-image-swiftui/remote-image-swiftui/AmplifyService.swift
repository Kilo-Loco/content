//
//  AmplifyService.swift
//  remote-image-swiftui
//
//  Created by Kilo Loco on 1/31/21.
//

import Amplify
import UIKit

extension String {
    var isNotEmpty: Bool {
        !isEmpty
    }
}

enum AmplifyService {
    
    private static var window: UIWindow {
        guard
            let scene = UIApplication.shared.connectedScenes.first,
            let delegate = scene.delegate as? UIWindowSceneDelegate,
            let window = delegate.window as? UIWindow
        else { return UIWindow() }
        return window
    }
    
    static func signInIfNeeded() {
        Amplify.Auth.fetchAuthSession { result in
            DispatchQueue.main.async {
                if (try? result.get().isSignedIn) != true {
                    Amplify.Auth.signInWithWebUI(
                        presentationAnchor: window,
                        listener: {_ in}
                    )
                }
            }
        }
    }
    
    static func getImageKeys(completion: @escaping ([String]) -> Void) {
        Amplify.Storage.list { listResult in
            print(listResult)
            let imageKeys = (try? listResult.get().items
                .map(\.key)
                .filter(\.isNotEmpty))
                ?? []
            
            completion(imageKeys)
        }
    }
}
