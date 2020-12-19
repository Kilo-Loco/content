// swiftlint:disable all
import Amplify
import Foundation

public struct Message: Model {
  public let id: String
  public var body: String
  public var authorUsername: String
  public var creationDate: Temporal.DateTime
  
  public init(id: String = UUID().uuidString,
      body: String,
      authorUsername: String,
      creationDate: Temporal.DateTime) {
      self.id = id
      self.body = body
      self.authorUsername = authorUsername
      self.creationDate = creationDate
  }
}