//
//  PasswordTextField.swift
//  Stylepoll
//
//  Created by Romesh Singhabahu on 30/09/2020.
//

import SwiftUI

struct PasswordTextField: View {
    
    @Binding var password: String
    
    var body: some View {
        HStack{
            Image(systemName: "lock.fill")
                .foregroundColor(COLOR_LIGHT_GRAY)
            SecureField(TEXT_PASSWORD, text: $password)
        }.modifier(TextFieldModifiers())
    }
}
