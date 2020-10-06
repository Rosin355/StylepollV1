//
//  SigninButton.swift
//  Stylepoll
//
//  Created by Romesh Singhabahu on 30/09/2020.
//

import SwiftUI

struct SignInButton: View {
    // MARK: - PROPERTIES
    var action: () -> Void
    var label: String
    
    
    // MARK: - BODY
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(label)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Spacer()
                
            }.modifier(SinginButtonModifier())
  
        }
    }
}
