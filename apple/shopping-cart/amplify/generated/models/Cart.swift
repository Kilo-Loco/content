// swiftlint:disable all
import Amplify
import Foundation

public struct Cart: Model {
  public let id: String
  
  public init(id: String = UUID().uuidString) {
      self.id = id
  }
}