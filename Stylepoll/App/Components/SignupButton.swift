//
//  SignupButton.swift
//  Stylepoll
//
//  Created by Romesh Singhabahu on 01/10/2020.
//

import SwiftUI

struct SignupButton: View {
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
