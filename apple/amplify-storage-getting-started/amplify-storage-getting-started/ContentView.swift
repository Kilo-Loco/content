//
//  ContentView.swift
//  amplify-storage-getting-started
//
//  Created by Kilo Loco on 10/9/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var fileStatus: String?
    
    var body: some View {
        if let fileStatus = self.fileStatus {
            Text(fileStatus)
        }
        Button("Upload File", action: {}).padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
