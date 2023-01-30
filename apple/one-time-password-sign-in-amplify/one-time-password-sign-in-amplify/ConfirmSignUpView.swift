//
//  ConfirmSignUpView.swift
//  one-time-password-sign-in-amplify
//
//  Created by Kilo Loco on 1/30/23.
//

import SwiftUI

struct ConfirmSignUpView: View {
    
    let didConfirmSignUp: () -> Void
    
    @State var verificationCode: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            Image("amplify-logo-large")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250)
            
            TextField("Verification Code", text: $verificationCode)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
            
            Button("Confirm Sign Up", action: {})
                .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding(.horizontal, 32)
    }
}

struct ConfirmSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmSignUpView(didConfirmSignUp: {})
    }
}
