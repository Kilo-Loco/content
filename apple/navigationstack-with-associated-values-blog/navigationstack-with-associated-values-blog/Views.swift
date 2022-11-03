//
//  Views.swift
//  navigationstack-with-associated-values-blog
//
//  Created by Kilo Loco on 10/20/22.
//

import SwiftDummyData
import SwiftUI

protocol Route: Hashable {}

extension DDUser: Hashable {
    public static func == (lhs: DDUser, rhs: DDUser) -> Bool {
        lhs.givenName == rhs.givenName &&
        lhs.familyName == rhs.familyName &&
        lhs.age == rhs.age
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(givenName)
        hasher.combine(familyName)
        hasher.combine(age)
    }
}

enum HomeRoute: Route {
    case buttonTap
    case selectRow(DDUser)
}

class Coordinator<Route>: ObservableObject {
    @Published var routes: [Route] = []
    
    func navigate(to route: Route) {
        routes.append(route)
    }
    
    @discardableResult
    func goBack() -> Route? {
        routes.popLast()
    }
    
    func popToRoot() {
        routes.removeAll()
    }
}

class HomeCoordinator: Coordinator<HomeRoute> {}

struct HomeView: View {
    
    @StateObject var coordinator: HomeCoordinator = .init()
    
    var body: some View {
        NavigationStack(path: $coordinator.routes) {
            List(DDUser.data) { user in
                NavigationLink(value: HomeRoute.selectRow(user)) {
                    Text(user.fullName)
                }
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem {
                    Button("Create User") {
                        coordinator.navigate(to: .buttonTap)
                    }
                }
            }
            .navigationDestination(for: HomeRoute.self) { route in
                switch route {
                case .buttonTap:
                    CreateUserView()
                case .selectRow(let user):
                    UserDetailsView(user: user)
                }
            }
        }
        .environmentObject(coordinator)
    }
}

struct UserDetailsView: View {
    @EnvironmentObject var coordinator: HomeCoordinator
    
    let user: DDUser
    
    var body: some View {
        VStack {
            Text("\(user.fullName) is \(user.age) years old")
            Button("Another User") {
                coordinator.navigate(to: .selectRow(DDUser.data.randomElement()!))
            }
            Button("Back to All Users") {
                coordinator.popToRoot()
            }
        }
    }
}

struct CreateUserView: View {
    
    @EnvironmentObject var coordinator: HomeCoordinator
    
    var body: some View {
        VStack {
            Text("Create User Here")
            Button("Post then go back", action: { coordinator.goBack() })
        }
    }
}


