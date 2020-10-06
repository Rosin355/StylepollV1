//
//  UsernameTextField.swift
//  Stylepoll
//
//  Created by Romesh Singhabahu on 01/10/2020.
//

import SwiftUI

struct UsernameTextField: View {
    @Binding var username: String
    
    var body: some View {
        HStack{
            Image(systemName: "person.fill")
                .foregroundColor(COLOR_LIGHT_GRAY)
            TextField(TEXT_USERNAME, text: $username)
        }.modifier(TextFieldModifiers())
    }
}
