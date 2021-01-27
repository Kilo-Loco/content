// swiftlint:disable all
import Amplify
import Foundation

extension CartProduct {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case cart
    case product
    case cartId
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let cartProduct = CartProduct.keys
    
    model.pluralName = "CartProducts"
    
    model.fields(
      .id(),
      .belongsTo(cartProduct.cart, is: .required, ofType: Cart.self, targetName: "cartProductCartId"),
      .belongsTo(cartProduct.product, is: .required, ofType: Product.self, targetName: "cartProductProductId"),
      .field(cartProduct.cartId, is: .required, ofType: .string)
    )
    }
}