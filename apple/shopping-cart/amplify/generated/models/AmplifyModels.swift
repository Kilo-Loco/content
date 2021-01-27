// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "7a96fce7792e7e080fc078ef7d36ea81"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: CartProduct.self)
    ModelRegistry.register(modelType: Cart.self)
    ModelRegistry.register(modelType: Product.self)
  }
}