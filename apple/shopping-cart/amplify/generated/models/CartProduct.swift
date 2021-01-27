// swiftlint:disable all
import Amplify
import Foundation

public struct CartProduct: Model {
  public let id: String
  public var cart: Cart
  public var product: Product
  public var cartId: String
  
  public init(id: String = UUID().uuidString,
      cart: Cart,
      product: Product,
      cartId: String) {
      self.id = id
      self.cart = cart
      self.product = product
      self.cartId = cartId
  }
}