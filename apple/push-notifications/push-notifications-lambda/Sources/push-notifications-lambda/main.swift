import AWSLambdaEvents
import AWSLambdaRuntime
import Foundation
import Pinpoint

let accessKeyId = ProcessInfo.processInfo.environment["AWS_ACCESS_KEY_ID"]
let secretAccessKey = ProcessInfo.processInfo.environment["AWS_SECRET_ACCESS_KEY"]
let pinpointApplicationId = ProcessInfo.processInfo.environment["PINPOINT_APP_ID"]

Lambda.run { (context, event: DynamoDB.Event, completion: @escaping (Result<String, Error>) -> Void) in
    
    guard let pinpointApplicationId = pinpointApplicationId else {
        return completion(.failure(LambdaError.noPinpointAppId))
    }
    
    for record in event.records {
        
        guard let snapshot = record.change.newImage ?? record.change.oldImage else {
            return completion(.failure(LambdaError.noSnapshot))
        }
        
        guard case .string(let deviceToken) = snapshot["deviceToken"] else {
            return completion(.failure(LambdaError.noDeviceToken))
        }
        
        guard case .string(let messageBody) = snapshot["body"] else {
            return completion(.failure(LambdaError.noMessageBody))
        }
        
        let pinpoint = Pinpoint(
            accessKeyId: accessKeyId,
            secretAccessKey: secretAccessKey,
            region: .uswest2
        )
        
        let message = Pinpoint.APNSMessage(
            body: messageBody,
            sound: "bingbong.aiff",
            title: "Sexy Swift Lambda"
        )
        
        let messageConfiguration = Pinpoint.DirectMessageConfiguration(aPNSMessage: message)
        
        let messageRequest = Pinpoint.MessageRequest(
            addresses: [deviceToken: Pinpoint.AddressConfiguration(channelType: .apnsSandbox)],
            messageConfiguration: messageConfiguration
        )
        
        let sendMessageRequest = Pinpoint.SendMessagesRequest(
            applicationId: pinpointApplicationId,
            messageRequest: messageRequest
        )
        
        pinpoint.sendMessages(sendMessageRequest)
            .whenComplete { result in
                switch result {
                case .success:
                    completion(.success("Sent message to \(deviceToken)"))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

enum LambdaError: LocalizedError {
    case noSnapshot
    case noDeviceToken
    case noMessageBody
    case noPinpointAppId
}
