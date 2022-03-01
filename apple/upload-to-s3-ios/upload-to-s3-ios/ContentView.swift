//
//  ContentView.swift
//  upload-to-s3-ios
//
//  Created by Kilo Loco on 2/17/22.
//
import Amplify
import SwiftUI

struct ContentView: View {
    let imageKey: String = "house-icon"
    @State var image: UIImage?
    
    var body: some View {
        VStack(spacing: 40) {
            if let image = self.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 100, height: 100)
            }
            Button("Upload", action: uploadImage)
            Button("Download", action: downloadImage)
        }
    }
    
    func uploadImage() {
        let houseImage = UIImage(systemName: "house")!
        let houseImageData = houseImage.jpegData(compressionQuality: 1)!
        
        Amplify.Storage.uploadData(key: imageKey, data: houseImageData) { result in
            switch result {
            case .success(let uploadedData):
                print(uploadedData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func downloadImage() {
        Amplify.Storage.downloadData(key: imageKey) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            case .failure(let error):
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
