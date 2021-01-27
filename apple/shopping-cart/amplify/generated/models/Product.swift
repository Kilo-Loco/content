// swiftlint:disable all
import Amplify
import Foundation

public struct Product: Model {
  public let id: String
  public var name: String
  public var price: Int
  
  public init(id: String = UUID().uuidString,
      name: String,
      price: Int) {
      self.id = id
      self.name = name
      self.price = price
  }
}