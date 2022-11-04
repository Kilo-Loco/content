//
//  ContentViews.swift
//  macos-navigation
//
//  Created by Kilo Loco on 11/4/22.
//

import SwiftDummyData
import SwiftUI

struct UsersView: View {
    var body: some View {
        List(DDUser.data) { user in
            Text(user.id)
        }
    }
}

struct UserDetailsView: View {
    let user: DDUser
    
    var body: some View {
        Text("Hello \(user.id)")
    }
}

struct AnimalsView: View {
    var body: some View {
        List(DDAnimal.data) { animal in
            Text(animal.id)
        }
    }
}

struct AnimalDetailsView: View {
    let animal: DDAnimal
    
    var body: some View {
        Text("Hello \(animal.id)")
    }
}

struct FoodView: View {
    var body: some View {
        List(DDFood.data) { food in
            Text(food.id)
        }
    }
}

struct FoodDetailsView: View {
    let food: DDFood
    
    var body: some View {
        Text("Hello \(food.id)")
    }
}
