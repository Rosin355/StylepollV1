//
//  StylepollApp.swift
//  Stylepoll
//
//  Created by Romesh Singhabahu on 30/09/2020.
//

import SwiftUI
import Firebase

@main
struct StylepollApp: App {
    
    init() {
     FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
