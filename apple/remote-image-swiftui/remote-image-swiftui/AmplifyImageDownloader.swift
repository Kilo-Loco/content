//
//  AmplifyImageDownloader.swift
//  remote-image-swiftui
//
//  Created by Kilo Loco on 1/31/21.
//

import Amplify
import Foundation

class AmplifyImageDownloader: ImageDownloader {
    let cacheKey: String
    
    init(_ key: String) {
        self.cacheKey = key
    }
    
    func downloadImageData(completion: @escaping (Data?) -> Void) {
        Amplify.Storage.downloadData(key: cacheKey) { result in
            let imageData = try? result.get()
            completion(imageData)
        }
    }
    
    
}
