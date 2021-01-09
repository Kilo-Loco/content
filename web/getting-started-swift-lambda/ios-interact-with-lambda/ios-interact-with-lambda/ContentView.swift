//
//  ContentView.swift
//  ios-interact-with-lambda
//
//  Created by Kilo Loco on 1/8/21.
//

import SwiftUI

struct Movie: Identifiable, Codable {
    let title: String
    
    var id: String {
        title
    }
}

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            List(viewModel.movies) { movie in
                Text(movie.title)
            }
            
            HStack {
                TextField("Enter a show title", text: $viewModel.text)
                
                Button("Send", action: viewModel.addShow)
            }
            .padding()
        }
    }
}

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var movies = [Movie]()
        @Published var text = ""
        
        func addShow() {
            let path = ""
            
            var request = URLRequest(url: URL(string: path)!)
            request.httpMethod = "POST"
            
            let movie = Movie(title: text)
            if let movieData = try? JSONEncoder().encode(movie) {
                request.httpBody = movieData
            }
            
            let task = URLSession.shared.dataTask(with: request) {
                
                if let error = $2 {
                    print(error)
                } else if let data = $0, let movies = try? JSONDecoder().decode([Movie].self, from: data) {
                    DispatchQueue.main.async { [weak self] in
                        self?.movies = movies
                        self?.text.removeAll()
                    }
                }
            }
            
            task.resume()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
