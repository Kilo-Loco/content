//
//  NetworkingService.swift
//  migrating-to-combine
//
//  Created by Kilo Loco on 10/13/20.
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
