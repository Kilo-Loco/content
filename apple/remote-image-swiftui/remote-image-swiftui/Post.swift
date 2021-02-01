//
//  Post.swift
//  remote-image-swiftui
//
//  Created by Kilo Loco on 1/31/21.
//

import Foundation

struct Post: Identifiable {
    let id = UUID().uuidString
    let imagePath: String
    
    init(imagePath: String = "https://www.kiloloco.com/images/memoji-circle.png") {
        self.imagePath = imagePath
    }
}
