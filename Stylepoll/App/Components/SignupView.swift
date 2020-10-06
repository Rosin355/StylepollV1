//
//  SignupView.swift
//  Stylepoll
//
//  Created by Romesh Singhabahu on 30/09/2020.
//

import SwiftUI

struct SignupView: View {
    var body: some View {
        HStack{
            Text(TEXT_NEED_AN_ACCOUNT)
                .font(.footnote)
                .foregroundColor(.secondary)
            
            Text(TEXT_SIGN_UP)
                .foregroundColor(.black)
        }
        .padding(.bottom)
    }
}
