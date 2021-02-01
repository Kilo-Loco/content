//
//  ContentView.swift
//  remote-image-swiftui
//
//  Created by Kilo Loco on 1/31/21.
//

import SwiftUI

struct ContentView: View {
    @State var posts = [Post()]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(posts) { post in
                        Text(post.imagePath)
                    }
                }
            }
            
            Button("Get more images", action: getMoreImages)
        }
            
    }
    
    func getMoreImages() {
        posts = [Post(), Post(), Post(), Post(), Post()]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
