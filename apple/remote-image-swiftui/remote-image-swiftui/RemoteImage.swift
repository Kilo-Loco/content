//
//  RemoteImage.swift
//  remote-image-swiftui
//
//  Created by Kilo Loco on 1/31/21.
//

import SwiftUI

protocol ImageDownloader {
    var cacheKey: String { get }
    func downloadImageData(completion: @escaping (Data?) -> Void)
}

class DefaultImageDownloader: ImageDownloader {
    let imagePath: String
    
    var cacheKey: String {
        imagePath
    }
    
    init(imagePath: String) {
        self.imagePath = imagePath
    }
    
    func downloadImageData(completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: imagePath) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                completion(data)
            }
        }
        dataTask.resume()
    }
}

class RemoteImageCache: NSCache<NSString, UIImage> {
    static let shared = RemoteImageCache()
    
    func cache(_ image: UIImage, for key: String) {
        self.setObject(image, forKey: key as NSString)
    }
    
    func getImage(for key: String) -> UIImage? {
        self.object(forKey: key as NSString)
    }
}

struct RemoteImage: View {
    
    @State var uiImage: UIImage?
    
    let placeholderImage: Image
    let imageDownloader: ImageDownloader
    
    init(placeholderImage: Image, imageDownloader: ImageDownloader) {
        self.placeholderImage = placeholderImage
        self.imageDownloader = imageDownloader
    }
    
    var body: some View {
        if let uiImage = self.uiImage {
            Image(uiImage: uiImage)
                .resizable()
        } else {
            placeholderImage
                .resizable()
                .onAppear(perform: getImage)
        }
    }
    
    private func getImage() {
        let cacheKey = imageDownloader.cacheKey
        if let cachedImage = RemoteImageCache.shared.getImage(for: cacheKey) {
            print("using cached image")
            self.uiImage = cachedImage
        } else {
            print("Downloading image")
            imageDownloader.downloadImageData { imageData in
                guard
                    let imageData = imageData,
                    let uiImage = UIImage(data: imageData)
                else {
                    self.uiImage = nil
                    return
                }
                
                RemoteImageCache.shared.cache(uiImage, for: cacheKey)
                
                DispatchQueue.main.async {
                    self.uiImage = uiImage
                }
            }
        }
    }
}

