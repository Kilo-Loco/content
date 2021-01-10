// swiftlint:disable all
import Amplify
import Foundation

public struct Message: Model {
  public let id: String
  public var body: String
  public var deviceToken: String
  
  public init(id: String = UUID().uuidString,
      body: String,
      deviceToken: String) {
      self.id = id
      self.body = body
      self.deviceToken = deviceToken
  }
}