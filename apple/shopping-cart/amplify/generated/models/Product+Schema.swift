// swiftlint:disable all
import Amplify
import Foundation

extension Product {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case name
    case price
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let product = Product.keys
    
    model.pluralName = "Products"
    
    model.fields(
      .id(),
      .field(product.name, is: .required, ofType: .string),
      .field(product.price, is: .required, ofType: .int)
    )
    }
}