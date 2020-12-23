//
//  AppDataService.swift
//  swiftui-mvvm
//
//  Created by Kilo Loco on 12/22/20.
//

import Foundation

protocol DataService {
    func getUsers(completion: @escaping ([User]) -> Void)
}

class AppDataService: DataService {
    func getUsers(completion: @escaping ([User]) -> Void) {
        DispatchQueue.main.async {
            completion([
                User(id: 1, name: "Kyle"),
                User(id: 2, name: "Jamal"),
                User(id: 3, name: "Lee")
            ])
        }
    }
}
