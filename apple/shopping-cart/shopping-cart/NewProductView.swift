//
//  NewProductView.swift
//  shopping-cart
//
//  Created by Kilo Loco on 1/26/21.
//

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
                Button("Submit", action: { print("\(viewModel.productName): \(viewModel.productPrice)") })
            }
            .navigationTitle("New Product")
        }
    }
}

extension NewProductView {
    class ViewModel: ObservableObject {
        @Published var productName = ""
        @Published var productPrice = 0
    }
}

struct NewProductView_Previews: PreviewProvider {
    static var previews: some View {
        NewProductView()
    }
}
