//
//  ProductsView.swift
//  shopping-cart
//
//  Created by Kilo Loco on 1/26/21.
//

import Amplify
import Combine
import SwiftUI

struct ProductsView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                List(viewModel.products, id: \.id) { product in
                    HStack {
                        Text("\(product.name): $\(product.price).00")
                        
                        Spacer()
                        
                        Button("Add to cart") {
                            viewModel.addToCart(product)
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
        @Published var products = [Product]()
        
        private var tokens = Set<AnyCancellable>()
        
        init() {
            getProducts()
            observeProducts()
        }
        
        func getProducts() {
            Amplify.DataStore.query(Product.self)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    print(completion)
                } receiveValue: { [weak self] products in
                    self?.products = products
                }
                .store(in: &tokens)
        }
        
        func observeProducts() {
            Amplify.DataStore.publisher(for: Product.self)
                .filter { $0.mutationType == "create" }
                .tryMap { try $0.decodeModel(as: Product.self) }
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    print(completion)
                } receiveValue: { [weak self] product in
                    self?.products.append(product)
                }
                .store(in: &tokens)

        }
        
        func addToCart(_ product: Product) {
            guard let cart = SessionManager.shared.currentUserCart else { return }
            
            let cartProduct = CartProduct(
                cart: cart,
                product: product,
                cartId: cart.id
            )
            
            Amplify.DataStore.save(cartProduct)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    print(completion)
                } receiveValue: { cartProduct in
                    print("saved", cartProduct)
                }
                .store(in: &tokens)
        }
        
        
        
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}
