//
//  SignInView.swift
//  Stylepoll
//
//  Created by Romesh Singhabahu on 30/09/2020.
//

import SwiftUI

struct SignInView: View {
    // MARK: - PROPERTIES
  
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HeaderView()
                Spacer()
                Text("Create an account to get access to all features")
                  .font(.headline)
                  .fontWeight(.medium)
                  .multilineTextAlignment(.center)
                Spacer()
                
                CustomSignInWithAppleButton()
                    .frame(minWidth: 100, maxWidth: 400).frame(height: 45)
                    .padding(.horizontal, 20)
                    .buttonStyle(SquishableButtonStyle())
                
                Divider()
                Text("By using Style Poll you agree to our Terms of Use and Service Policy")
                  .multilineTextAlignment(.center)
              
            }
        }.accentColor(Color.black)
    }
}


struct CustomSignInWithAppleButton: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  var body: some View {
    Group {
      if colorScheme == .light {
        AppleSignInCoordinator(colorScheme: .light)
      }
      else {
        AppleSignInCoordinator(colorScheme: .dark)
      }
    }
  }
}

// MARK: - PREVIEW
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .previewDevice("iPhone 11")
    }
}






