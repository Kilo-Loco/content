//
//  CameraView.swift
//  amplify-datastore-storage
//
//  Created by Kyle Lee on 8/12/20.
//

import Amplify
import SwiftUI

struct CameraView: View {
    
    @State var shouldShowImagePicker = false
    @State var image: UIImage?
    
    var body: some View {
        VStack {
            if let image = self.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            Spacer()
            Button(action: didTapButton, label: {
                let imageName = self.image == nil
                    ? "camera"
                    : "icloud.and.arrow.up"
                Image(systemName: imageName)
                    .font(.largeTitle)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            })
            Spacer()
        }
        .sheet(isPresented: $shouldShowImagePicker, content: {
            ImagePicker(image: $image)
        })
    }
    
    func didTapButton() {
        if let image = self.image {
            // upload image
            upload(image)
            
        } else {
            shouldShowImagePicker.toggle()
        }
    }
    
    func upload(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let key = UUID().uuidString + ".jpg"
        
        _ = Amplify.Storage.uploadData(key: key, data: imageData) { result in
            switch result {
            case .success:
                print("Uploaded image")
                
                // Save image to a Post
                let post = Post(imageKey: key)
                save(post)
                
            case .failure(let error):
                print("Failed to upload - \(error)")
            }
        }
    }
    
    func save(_ post: Post) {
        Amplify.DataStore.save(post) { result in
            switch result {
            case .success:
                print("post saved")
                self.image = nil
                
            case .failure(let error):
                print("failed to save post - \(error)")
            }
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
