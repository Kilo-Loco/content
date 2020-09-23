//
//  SessionView.swift
//  Auth-Web-UI
//
//  Created by Kyle Lee on 7/28/20.
//

import SwiftUI

struct SessionView: View {
    @EnvironmentObject var auth: AuthService
    
    var body: some View {
        VStack {
            Spacer()
            Text("You have signed in")
            Spacer()
            Button("Sign Out", action: auth.signOut)
        }
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView()
    }
}
