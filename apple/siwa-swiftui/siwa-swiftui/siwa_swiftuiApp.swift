//
//  siwa_swiftuiApp.swift
//  siwa-swiftui
//
//  Created by Kilo Loco on 3/8/21.
//

import Amplify
import AmplifyPlugins
import AuthenticationServices
import SwiftUI

@main
struct siwa_swiftuiApp: App {
    
    init() {
        configureAmplify()
        attemptAutoSignIn()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func configureAmplify() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            print("Successfully configured Amplify")
            
        } catch {
            print("Could not configure Amplify", error)
        }
    }
    
    func attemptAutoSignIn() {
        guard
            let plugin = try? Amplify.Auth.getPlugin(for: AWSCognitoAuthPlugin().key),
            let authPlugin = plugin as? AWSCognitoAuthPlugin,
            case .awsMobileClient(let client) = authPlugin.getEscapeHatch(),
            let loginResults = client.logins().result,
            let userId = loginResults[AuthProvider.signInWithApple.rawValue] as? String
        else { return }
        
        getCredentialsState(for: userId)
    }
    
    func getCredentialsState(for userId: String) {
        let provider = ASAuthorizationAppleIDProvider()
        provider.getCredentialState(forUserID: userId) { (credentialsState, error) in
            if let unwrappedError = error {
                print(unwrappedError)
            }
            switch credentialsState {
            case .authorized:
                print("Authorized")
            case .notFound, .revoked:
                print("Unauthenticated")
            case .transferred:
                print("needs transfer")
                
            @unknown default:
                print("")
            }
        }
    }
}
