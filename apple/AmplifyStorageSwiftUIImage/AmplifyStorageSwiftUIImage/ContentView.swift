//
//  ContentView.swift
//  AmplifyStorageSwiftUIImage
//
//  Created by Kilo Loco on 9/28/22.
//

import Amplify
import SwiftUI

struct ContentView: View {
    @State var imageKeys: [String] = []
    
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(imageKeys, id: \.self) { key in
                    Text(key)
                }
            }
        }
        .onAppear(perform: getImageKeys)
    }
    
    func getImageKeys() {
        Amplify.Storage.list { result in
            if case .success(let storageResult) = result {
                self.imageKeys = storageResult.items
                    .map(\.key)
                    .filter { $0.isEmpty == false }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
