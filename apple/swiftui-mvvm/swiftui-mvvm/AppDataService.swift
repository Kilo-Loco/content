//
//  AppDataService.swift
//  swiftui-mvvm
//
//  Created by Kilo Loco on 12/22/20.
//

import Foundation

class AppDataService {
    func getUsers(completion: @escaping ([User]) -> Void) {
        completion([
            User(id: 1, name: "Kyle"),
            User(id: 2, name: "Jamal"),
            User(id: 3, name: "Lee")
        ])
    }
}
