//
//  ContentView.swift
//  amplify-ios-import-bucket
//
//  Created by Kilo Loco on 1/29/21.
//

import Amplify
import SwiftUI

struct ContentView: View {
    
    @State var isSignIn = false
    @State var image: UIImage?
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            if isSignIn {
                Button("Get Image", action: getImage)
            } else {
                Button("Sign In", action: signIn)
            }
        }
        .onAppear(perform: checkSessionStatus)
    }
    
    func checkSessionStatus() {
        Amplify.Auth.fetchAuthSession { result in
            isSignIn = (try? result.get().isSignedIn) == true
        }
    }
    
    var window: UIWindow {
        guard
            let scene = UIApplication.shared.connectedScenes.first,
            let delegate = scene.delegate as? UIWindowSceneDelegate,
            let window = delegate.window as? UIWindow
        else { return UIWindow() }
        return window
    }
    
    func signIn() {
        Amplify.Auth.signInWithWebUI(presentationAnchor: window) { _ in
            checkSessionStatus()
        }
    }
    
    func getImage() {
        Amplify.Storage.list { result in
            do {
                let listResult = try result.get()
//                listResult.items.forEach { print($0) }
                
                guard let amplifyLogoKey = listResult.items.first(where: {!$0.key.isEmpty})?.key else { return }
                
                Amplify.Storage.downloadData(key: amplifyLogoKey) { result in
                    do {
                        let imageData = try result.get()
                        let image = UIImage(data: imageData)
                        self.image = image
                        
                    } catch {
                        print(error)
                    }
                }
                
            } catch {
                print(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
