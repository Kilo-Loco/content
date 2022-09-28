// swiftlint:disable all
import Amplify
import Foundation

public struct Product: Model {
  public let id: String
  public var name: String
  public var price: Int
  public var imageKey: String
  public var productDescription: String?
  public var userId: String
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      name: String,
      price: Int,
      imageKey: String,
      productDescription: String? = nil,
      userId: String) {
    self.init(id: id,
      name: name,
      price: price,
      imageKey: imageKey,
      productDescription: productDescription,
      userId: userId,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      name: String,
      price: Int,
      imageKey: String,
      productDescription: String? = nil,
      userId: String,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.name = name
      self.price = price
      self.imageKey = imageKey
      self.productDescription = productDescription
      self.userId = userId
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}