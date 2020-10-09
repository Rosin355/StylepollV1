//
//  MainView.swift
//  Stylepoll
//
//  Created by Romesh Singhabahu on 30/09/2020.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var model: SPModel
    @State var showLogin = false
    
    var body: some View {
        content
        // here you set your navigation toolbar item
    }
    
    
    var content: some View {
        VStack {
            
            Text("This is your main view")
           
        }.sheet(isPresented: $showLogin) {
            NavigationView {
                SignInView()
            }
            
        }
        .onAppear{
            // checking if there is a user registered
            if model.isUserAuthenticated == .undefined || model.isUserAuthenticated == .signedOut {
                showLogin = true
            }
            model.configureFirebaseStateDidChange()
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
