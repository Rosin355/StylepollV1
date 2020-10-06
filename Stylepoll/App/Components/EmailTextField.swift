//
//  EmailTextField.swift
//  Stylepoll
//
//  Created by Romesh Singhabahu on 30/09/2020.
//

import SwiftUI

struct EmailTextField: View {
    
    @Binding var email: String
    
    var body: some View {
        HStack{
            Image(systemName: "envelope.fill")
                .foregroundColor(COLOR_LIGHT_GRAY)
            TextField(TEXT_EMAIL, text: $email)
        }.modifier(TextFieldModifiers())
    }
}
