//
//  shopping_cartApp.swift
//  shopping-cart
//
//  Created by Kilo Loco on 1/26/21.
//

import Amplify
import AmplifyPlugins
import Combine
import SwiftUI

let CART_ID = "kilos-cart"

class SessionManager {
    private init() {}
    static let shared = SessionManager()
    
    var currentUserCart: Cart?
}

@main
struct shopping_cartApp: App {
    
    @ObservedObject var viewModel = ViewModel()
    
    init() {
        configureAmplify()
        viewModel.seedCartIfNeeded()
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ProductsView()
                    .tabItem { Image(systemName: "square.fill.text.grid.1x2") }
                
                CartView()
                    .tabItem { Image(systemName: "cart") }
            }
        }
    }
    
    private func configureAmplify() {
        
        let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
        do {
            try Amplify.add(plugin: dataStorePlugin)
            try Amplify.configure()
            print("Initialized Amplify");
        } catch {
            print("Could not initialize Amplify: \(error)")
        }
        
    }
}


extension shopping_cartApp {
    class ViewModel: ObservableObject {
        
        private var token: AnyCancellable?
        func seedCartIfNeeded() {
            token = Amplify.DataStore.query(Cart.self, byId: CART_ID)
                .flatMap { queriedCart -> AnyPublisher<Cart, DataStoreError> in
                    if let queriedCart = queriedCart {
                        print("Using queried cart")
                        return Just(queriedCart)
                            .setFailureType(to: DataStoreError.self)
                            .eraseToAnyPublisher()
                    } else {
                        print("Creating cart")
                        let newCart = Cart(id: CART_ID)
                        return Amplify.DataStore.save(newCart)
                    }
                }
                .receive(on: DispatchQueue.main)
                .sink { (completion) in
                    print(completion)
                } receiveValue: { cart in
                    print(cart)
                    SessionManager.shared.currentUserCart = cart
                }

        }
    }
}
