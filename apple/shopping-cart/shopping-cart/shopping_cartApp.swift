//
//  shopping_cartApp.swift
//  shopping-cart
//
//  Created by Kilo Loco on 1/26/21.
//

import Amplify
import AmplifyPlugins
import SwiftUI

@main
struct shopping_cartApp: App {
    
    init() {
        configureAmplify()
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
        
    }
}
