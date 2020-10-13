//
//  NetworkingService.swift
//  migrating-to-combine
//
//  Created by Kilo Loco on 10/13/20.
//

import Foundation

enum NetworkingService {
    static func getAnimals(completion: @escaping (Result<[Animal], Error>) -> Void) {
        let animals: [Animal] = [.dog, .cat, .frog, .panda, .lion]
        completion(.success(animals))
    }
}
