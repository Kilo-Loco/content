//
//  ContentView.swift
//  amplify-storage-getting-started
//
//  Created by Kilo Loco.
//
import Amplify
import SwiftUI

struct ContentView: View {
    
    @State var fileStatus: String?
    
    var body: some View {
        if let fileStatus = self.fileStatus {
            Text(fileStatus)
        }
        Button("Upload File", action: uploadFile).padding()
    }
    
    func uploadFile() {
        let fileKey = "testFile.txt"
        let fileContents = "This is my dummy file"
        let fileData = fileContents.data(using: .utf8)!
        
        Amplify.Storage.uploadData(
            key: fileKey,
            data: fileData
        ) { result in
            
            switch result {
            case .success(let key):
                print("file with key \(key) uploaded")
                
                DispatchQueue.main.async {
                    fileStatus = "File Uploaded"
                }
                
            case .failure(let storageError):
                print("Failed to upload file", storageError)
                
                DispatchQueue.main.async {
                    fileStatus = "Failed to upload file"
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
