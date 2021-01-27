//
//  NewProductView.swift
//  shopping-cart
//
//  Created by Kilo Loco on 1/26/21.
//

import Amplify
import Combine
import SwiftUI

struct NewProductView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Product name", text: $viewModel.productName)
                    Stepper(
                        "Product price: \(viewModel.productPrice)",
                        value: $viewModel.productPrice
                    )
                }
                Button("Submit", action: viewModel.createProduct)
            }
            .navigationTitle("New Product")
        }
        .onAppear {
            viewModel.configure(with: presentationMode)
        }
    }
}

extension NewProductView {
    class ViewModel: ObservableObject {
        @Published var productName = ""
        @Published var productPrice = 0
        
        private var presentationMode: Binding<PresentationMode>?
        
        func configure(with presentationMode: Binding<PresentationMode>) {
            self.presentationMode = presentationMode
        }
        
        
        
        private var token: AnyCancellable?
        func createProduct() {
            let product = Product(
                name: productName,
                price: productPrice
            )
            
            token = Amplify.DataStore.save(product)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    print(completion)
                } receiveValue: { [weak self] savedProduct in
                    print("saved \(savedProduct.name)")
                    self?.presentationMode?.wrappedValue.dismiss()
                }

        }
    }
}

struct NewProductView_Previews: PreviewProvider {
    static var previews: some View {
        NewProductView()
    }
}
