// swiftlint:disable all
import Amplify
import Foundation

public struct Location: Model {
  public let id: String
  public var name: String
  public var latitude: Double
  public var longitude: Double
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      name: String,
      latitude: Double,
      longitude: Double) {
    self.init(id: id,
      name: name,
      latitude: latitude,
      longitude: longitude,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      name: String,
      latitude: Double,
      longitude: Double,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.name = name
      self.latitude = latitude
      self.longitude = longitude
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}