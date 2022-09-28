// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "6fdad4efb905bde353aa1cd624e873f9"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: Message.self)
    ModelRegistry.register(modelType: User.self)
    ModelRegistry.register(modelType: ChatRoom.self)
    ModelRegistry.register(modelType: Product.self)
  }
}