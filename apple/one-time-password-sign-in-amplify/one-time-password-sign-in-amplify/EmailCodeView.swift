//
//  EmailCodeView.swift
//  one-time-password-sign-in-amplify
//
//  Created by Kilo Loco on 1/30/23.
//

import SwiftUI

struct EmailCodeView: View {
    
    let username: String
    let didConfirmLogin: () -> Void
    
    @State var emailCode: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            Image("amplify-logo-large")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250)
            
            TextField("Email Code", text: $emailCode)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
            
            Button("Confirm Login", action: {})
                .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding(.horizontal, 32)
    }
}

struct EmailCodeView_Previews: PreviewProvider {
    static var previews: some View {
        EmailCodeView(username: "kiloloco", didConfirmLogin: {})
    }
}
