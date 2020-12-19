// swiftlint:disable all
import Amplify
import Foundation

public struct User: Model {
  public let id: String
  public var username: String
  
  public init(id: String = UUID().uuidString,
      username: String) {
      self.id = id
      self.username = username
  }
}