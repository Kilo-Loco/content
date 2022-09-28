// swiftlint:disable all
import Amplify
import Foundation

public struct ChatRoom: Model {
  public let id: String
  public var memberIds: [String]?
  public var lastMessage: LastMessage?
  public var messages: List<Message>?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      memberIds: [String]? = nil,
      lastMessage: LastMessage? = nil,
      messages: List<Message>? = []) {
    self.init(id: id,
      memberIds: memberIds,
      lastMessage: lastMessage,
      messages: messages,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      memberIds: [String]? = nil,
      lastMessage: LastMessage? = nil,
      messages: List<Message>? = [],
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.memberIds = memberIds
      self.lastMessage = lastMessage
      self.messages = messages
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}