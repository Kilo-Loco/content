// swiftlint:disable all
import Amplify
import Foundation

extension Message {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case body
    case authorUsername
    case creationDate
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let message = Message.keys
    
    model.pluralName = "Messages"
    
    model.fields(
      .id(),
      .field(message.body, is: .required, ofType: .string),
      .field(message.authorUsername, is: .required, ofType: .string),
      .field(message.creationDate, is: .required, ofType: .dateTime)
    )
    }
}