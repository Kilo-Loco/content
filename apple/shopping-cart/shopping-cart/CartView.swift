//
//  CartView.swift
//  shopping-cart
//
//  Created by Kilo Loco on 1/26/21.
//

import Amplify
import Combine
import SwiftUI

struct CartView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                List(viewModel.products, id: \.id) { product in
                    HStack {
                        Text(product.name)
                        Spacer()
                        Text("$\(product.price).00")
                    }
                }
                .listStyle(InsetGroupedListStyle())

                ZStack {
                    Color(.systemBackground)
                        .shadow(color: .gray, radius: 4, x: 0, y: 2)

                    HStack {
                        Text("Subtotal: $\(viewModel.subtotal).00")
                            .bold()

                        Spacer()

                        Button("Check out", action: {})
                            .padding(8)
                            .foregroundColor(.white)
                            .background(Color.purple)
                            .cornerRadius(4)
                    }
                    .padding()
                }
                .frame(height: 60)
            }
            .navigationTitle("Cart")
        }
    }
}

extension CartView {
    class ViewModel: ObservableObject {
        @Published var products = [Product]()
        
        var subtotal: Int {
            products.reduce(0) { (result, product) -> Int in
                result + product.price
            }
        }
        
        init() {
            getProducts()
            observeCart()
        }
        
        private var tokens = Set<AnyCancellable>()
        func getProducts() {
            guard let currentCartId = SessionManager.shared.currentUserCart?.id else { return }
            
            Amplify.DataStore.query(
                CartProduct.self,
                where: CartProduct.keys.cartId == currentCartId
            )
            .map { $0.map(\.product) }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] products in
                self?.products = products
            }
            .store(in: &tokens)
        }
        
        private func observeCart() {
            guard let currentCartId = SessionManager.shared.currentUserCart?.id else { return }
            
            Amplify.DataStore.publisher(for: CartProduct.self)
                .filter { $0.mutationType == "create" }
                .tryMap { try $0.decodeModel(as: CartProduct.self) }
                .filter { $0.cartId == currentCartId }
                .map(\.product)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    print(completion)
                } receiveValue: { [weak self] product in
                    self?.products.append(product)
                }
                .store(in: &tokens)

        }
        
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
