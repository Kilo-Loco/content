// swiftlint:disable all
import Amplify
import Foundation

public struct Note: Model {
  public let id: String
  public var body: String
  public var creationDate: Temporal.DateTime
  
  public init(id: String = UUID().uuidString,
      body: String,
      creationDate: Temporal.DateTime) {
      self.id = id
      self.body = body
      self.creationDate = creationDate
  }
}