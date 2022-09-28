// swiftlint:disable all
import Amplify
import Foundation

public struct LastMessage: Embeddable {
  var body: String
  var dateTime: Temporal.DateTime
  var productId: String
}