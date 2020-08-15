// swiftlint:disable all
import Amplify
import Foundation

public struct Post: Model {
  public let id: String
  public var imageKey: String
  
  public init(id: String = UUID().uuidString,
      imageKey: String) {
      self.id = id
      self.imageKey = imageKey
  }
}