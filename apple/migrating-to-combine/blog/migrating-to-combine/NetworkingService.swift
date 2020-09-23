//
//  NetworkingService.swift
//  migrating-to-combine
//
//  Created by Kyle Lee on 8/30/20.
//

import Combine
import Foundation

enum NetworkingService {
    static func getAnimals() -> Future<[Animal], Error> {
        return Future { promise in
            let animals: [Animal] = [.dog, .cat, .frog, .panda, .lion]
            promise(.success(animals))
        }
    }
}
