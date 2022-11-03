//
//  ContentViews.swift
//  macos-navigation-blog
//
//  Created by Kilo Loco on 11/2/22.
//

import SwiftDummyData
import SwiftUI

struct UsersView: View {
    let selectedUser: Binding<DDUser?>
    
    var body: some View {
        List(DDUser.data, selection: selectedUser) { user in
            NavigationLink(user.id, value: user)
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
    let selectedAnimal: Binding<DDAnimal?>
    
    var body: some View {
        List(DDAnimal.data, selection: selectedAnimal) { animal in
            NavigationLink(animal.id, value: animal)
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
    let selectedFood: Binding<DDFood?>
    
    var body: some View {
        List(DDFood.data, selection: selectedFood) { food in
            NavigationLink(food.id, value: food)
        }
    }
}

struct FoodDetailsView: View {
    let food: DDFood
    
    var body: some View {
        Text("Hello \(food.id)")
    }
}
