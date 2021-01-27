//
//  ProductsView.swift
//  shopping-cart
//
//  Created by Kilo Loco on 1/26/21.
//

import SwiftUI

struct ProductsView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                List([(name: "Product name", price: 5)], id: \.name) { product in
                    HStack {
                        Text("Product name: $5.00")
                        
                        Spacer()
                        
                        Button("Add to cart") {
                            print("Add \(product.name)")
                        }
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.purple)
                        .cornerRadius(4)
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
                Button(action: { viewModel.newProductViewIsVisible.toggle() }) {
                    Image(systemName: "plus")
                        .font(.largeTitle)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.purple)
                        .clipShape(Circle())
                        .padding()
                }
            }
            .navigationTitle("Products")
        }
        .sheet(
            isPresented: $viewModel.newProductViewIsVisible,
            content: { NewProductView() }
        )
    }
}

extension ProductsView {
    class ViewModel: ObservableObject {
        @Published var newProductViewIsVisible = false
        
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}
