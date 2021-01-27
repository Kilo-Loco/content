// swiftlint:disable all
import Amplify
import Foundation

extension Cart {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let cart = Cart.keys
    
    model.pluralName = "Carts"
    
    model.fields(
      .id()
    )
    }
}