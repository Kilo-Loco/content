//
//  ContentView.swift
//  swiftui-infinite-scrolling
//
//  Created by Kilo Loco on 10/6/20.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var sot = SourceOfTruth()
    @State var nextIndex = 1
    
    init() {
        sot.getAnimals(at: 0)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(sot.animals.indices, id: \.self) { animalIndex in
                        let animal = sot.animals[animalIndex]
                        Text("\(animal.emoji) \(animal.name)")
                            .padding(.vertical, 30)
                            .onAppear {
                                if animalIndex == sot.animals.count - 2 {
                                    sot.getAnimals(at: nextIndex)
                                    nextIndex += 1
                                }
                            }
                    }
                }
            }
            .navigationTitle("Animals")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
