//
//  SignInView.swift
//  Stylepoll
//
//  Created by Romesh Singhabahu on 30/09/2020.
//

import SwiftUI

struct SignInView: View {
    // MARK: - PROPERTIES
    @State var email: String = ""
    @State var password: String = ""
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HeaderView()
                Spacer()
                Divider()
                EmailTextField(email: $email)
                PasswordTextField(password: $password)
                SignInButton(action: {}, label: TEXT_SIGN_IN)
                Divider()
                NavigationLink(
                    destination: SignUpView()) {
                    SignupView()
                }
            }
        }.accentColor(Color.black)
    }
}

// MARK: - PREVIEW
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .previewDevice("iPhone 11")
    }
}






