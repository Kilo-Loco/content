//
//  ContentView.swift
//  remote-image-swiftui
//
//  Created by Kilo Loco on 1/31/21.
//

import SwiftUI

struct ContentView: View {
    @State var posts = [Post]()
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(posts) { post in
                        RemoteImage(
                            placeholderImage: Image(systemName: "photo"),
                            imageDownloader: AmplifyImageDownloader(post.imageKey)
                        )
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 250)
                    }
                }
            }
            
            Button("Get more images", action: getMoreImages)
        }
            
    }
    
    func getMoreImages() {
        AmplifyService.getImageKeys { keys in
            let posts = keys.map { Post(imageKey: $0) }
            self.posts = posts
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
