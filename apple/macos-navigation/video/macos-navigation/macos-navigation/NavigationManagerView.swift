//
//  NavigationManagerView.swift
//  macos-navigation
//
//  Created by Kilo Loco on 11/4/22.
//

import SwiftDummyData
import SwiftUI

enum SideBarItem: String, Identifiable, CaseIterable {
    var id: String { rawValue }
    
    case users
    case animals
    case food
}

enum DetailItem: Hashable {
    case user(DDUser)
    case animal(DDAnimal)
    case food(DDFood)
}

struct NavigationManagerView: View {
    @State var sideBarVisibility: NavigationSplitViewVisibility = .doubleColumn
    @State var selectedSideBarItem: SideBarItem = .users
    
    @State var selectedUser: DDUser?
    @State var selectedAnimal: DDAnimal?
    @State var selectedFood: DDFood?
    
    var selectedDetailItem: DetailItem? {
        if let user = selectedUser {
            return .user(user)
        } else if let animal = selectedAnimal {
            return .animal(animal)
        } else if let food = selectedFood {
            return .food(food)
        } else {
            return nil
        }
    }
    
    var body: some View {
        NavigationSplitView(columnVisibility: $sideBarVisibility) {
            List(SideBarItem.allCases, selection: $selectedSideBarItem) { item in
                NavigationLink(
                    item.rawValue.localizedCapitalized,
                    value: item
                )
            }
            .onChange(of: selectedSideBarItem) { _ in
                self.selectedUser = nil
                self.selectedFood = nil
                self.selectedAnimal = nil
            }
        } content: {
            switch selectedSideBarItem {
            case .users:
                UsersView(selectedUser: $selectedUser)
            case .animals:
                AnimalsView(selectedAnimal: $selectedAnimal)
            case .food:
                FoodView(selectedFood: $selectedFood)
            }
        } detail: {
            if let detailItem = selectedDetailItem {
                switch detailItem {
                case .user(let user):
                    UserDetailsView(user: user)
                case .animal(let animal):
                    AnimalDetailsView(animal: animal)
                case .food(let food):
                    FoodDetailsView(food: food)
                }
            }
        }
    }
}
