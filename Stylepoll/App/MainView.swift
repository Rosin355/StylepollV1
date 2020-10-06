//
//  MainView.swift
//  Stylepoll
//
//  Created by Romesh Singhabahu on 30/09/2020.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            SignInView()
                .tabItem {
                    Image(systemName: "bolt")
                }
        } //: TAB
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
