//
//  NetworkingService.swift
//  migrating-to-combine
//
//  Created by Kyle Lee on 8/30/20.
//

import Foundation

enum NetworkingService {
    static func getAnimals(completion: @escaping (Result<[Animal], Error>) -> Void) {
        let animals: [Animal] = [.dog, .cat, .frog, .panda, .lion]
        completion(.success(animals))
    }
}
