//
//  ContentView.swift
//  quick-note
//
//  Created by Kilo Loco on 12/18/20.
//

import Amplify
import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.notes) { note in
                            VStack {
                                Text(note.body)
                                Divider()
                            }
                        }
                    }
                }
                
                Button(action: { viewModel.isComposeNoteVisible = true}) {
                    Image(systemName: "plus")
                        .font(.largeTitle)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.purple)
                        .clipShape(Circle())
                        .padding()
                }
            }
            .navigationTitle("Notes")
        }
        .onAppear(perform: viewModel.getNotes)
        .sheet(isPresented: $viewModel.isComposeNoteVisible, content: {
            ZStack(alignment: .bottomTrailing) {
                TextEditor(text: $viewModel.noteText)
                Button("Save", action: viewModel.createNote)
            }
        })
    }
}

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var notes = [Note]()
        
        @Published var isComposeNoteVisible = false
        
        @Published var noteText = ""
        
        func getNotes() {
            Amplify.DataStore.query(Note.self) { result in
                do {
                    let notes = try result.get()
                    DispatchQueue.main.async {
                        self.notes = notes
                    }
                } catch {
                    print(error)
                }
            }
        }
        
        func createNote() {
            let item = Note(
                    body: noteText,
                    creationDate: Temporal.DateTime(Date()))
            Amplify.DataStore.save(item) { result in
                switch(result) {
                case .success(let savedItem):
                    print("Saved item: \(savedItem.id)")
                    self.getNotes()
                    self.isComposeNoteVisible = false
                    
                case .failure(let error):
                    print("Could not save item to DataStore: \(error)")
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
