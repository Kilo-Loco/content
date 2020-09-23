//
//  AuthService.swift
//  Auth-Web-UI
//
//  Created by Kyle Lee on 7/28/20.
//

import Amplify
import Foundation

class AuthService: ObservableObject {
    @Published var isSignedIn = false
    
    func checkSessionStatus() {
        _ = Amplify.Auth.fetchAuthSession { [weak self] result in
            switch result {
            case .success(let session):
                DispatchQueue.main.async {
                    self?.isSignedIn = session.isSignedIn
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private var window: UIWindow {
        guard
            let scene = UIApplication.shared.connectedScenes.first,
            let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
            let window = windowSceneDelegate.window as? UIWindow
        else { return UIWindow() }
        
        return window
    }

    func webSignIn() {
        _ = Amplify.Auth.signInWithWebUI(presentationAnchor: window) { result in
            switch result {
            case .success:
                print("Signed in")
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func observeAuthEvents() {
        _ = Amplify.Hub.listen(to: .auth) { [weak self] result in
            switch result.eventName {
            case HubPayload.EventName.Auth.signedIn:
                DispatchQueue.main.async {
                    self?.isSignedIn = true
                }
                
            case HubPayload.EventName.Auth.signedOut,
                 HubPayload.EventName.Auth.sessionExpired:
                DispatchQueue.main.async {
                    self?.isSignedIn = false
                }
                
            default:
                break
            }
        }
    }
    
    func signOut() {
        _ = Amplify.Auth.signOut { result in
            switch result {
            case .success:
                print("Signed out")
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
