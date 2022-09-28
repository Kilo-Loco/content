// swiftlint:disable all
import Amplify
import Foundation

extension Message {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case body
    case dateTime
    case sender
    case chatroomID
    case createdAt
    case updatedAt
    case messageSenderId
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let message = Message.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Messages"
    
    model.attributes(
      .index(fields: ["chatroomID"], name: "byChatRoom")
    )
    
    model.fields(
      .id(),
      .field(message.body, is: .required, ofType: .string),
      .field(message.dateTime, is: .required, ofType: .string),
      .hasOne(message.sender, is: .optional, ofType: User.self, associatedWith: User.keys.id, targetName: "messageSenderId"),
      .field(message.chatroomID, is: .required, ofType: .string),
      .field(message.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(message.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(message.messageSenderId, is: .optional, ofType: .string)
    )
    }
}